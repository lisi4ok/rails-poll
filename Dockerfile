# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t rails_poll .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name rails_poll rails_poll

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.5
FROM docker.io/library/ruby:${RUBY_VERSION}-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        vim curl wget libjemalloc2 libvips libxml2-dev \
        ffmpeg mupdf mupdf-tools libvips-dev poppler-utils imagemagick \
        sqlite3 libsqlite3-dev \
        mariadb-client libmariadb-dev \
        postgresql-client postgresql-contrib && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set environment
ARG ENVIRONMENT=development
ENV RAILS_ENV=${ENVIRONMENT} \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle

RUN if [ "${ENVIRONMENT}" = "production" ]; then \
      export BUNDLE_WITHOUT=development; \
    fi

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential git libpq-dev libyaml-dev pkg-config unzip && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Bun (use POSIX-compatible test so /bin/sh works; guard empty var)
ARG BUN_VERSION
ENV BUN_INSTALL=/usr/local/bun
ENV PATH=${BUN_INSTALL}/bin:${PATH}

RUN if [ -z "${BUN_VERSION}" ]; then \
      curl -fsSL https://bun.sh/install | bash; \
    else \
      curl -fsSL https://bun.sh/install | bash -s -- "bun-v${BUN_VERSION}"; \
    fi

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Install node modules
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Copy application code
COPY . .

# Create master key if it doesn't exist (after copying application code)
RUN if [ ! -f ./config/master.key ]; then \
    if [ "${ENVIRONMENT}" = "production" ]; then \
      ./bin/rails credentials:edit --environment ${ENVIRONMENT}; \
    else \
      ./bin/rails credentials:edit; \
    fi \
fi

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Adjust binfiles to be executable on Linux
RUN chmod +x bin/*
RUN sed -i 's/\r$//' bin/dev

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails
COPY --from=oven/bun:alpine /usr/local/bin/bun /usr/local/bin/bun

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server via Thruster by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/thrust", "./bin/rails", "server"]
