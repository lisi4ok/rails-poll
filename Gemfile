source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2", ">= 8.0.2.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Vite.js for Rails [https://github.com/vitejs/vite-rails]
gem "vite_rails", "~> 3.0"
# Inertia.js for Rails [https://github.com/inertiajs/inertia-rails] [https://inertiajs.com]
gem "inertia_rails", "~> 3.11"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
#gem "jsbundling-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
#gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
#gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
#gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See [https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem]
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Combine pry with byebug [https://github.com/deivid-rodriguez/pry-byebug]
  # gem "pry-byebug"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Load environment variables from .env into ENV [https://github.com/bkeepers/dotenv]
  gem "dotenv"

  # Faker [https://github.com/faker-ruby/faker]
  gem "faker"

  # Factory Bot Rails [https://github.com/faker-ruby/faker]
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # RSpec [https://rspec.info] [https://github.com/rspec/rspec-rails]
  gem "rspec-rails", "~> 8.0.2"

  # Database cleaner [https://github.com/rails/web-console]
  gem "database_cleaner"

  # You can seamlessly choose between Selenium, Webkit or pure Ruby drivers. [https://github.com/teamcapybara/capybara]
  gem "capybara"

  # Selenium [https://github.com/SeleniumHQ/selenium/tree/trunk/rb]
  gem "selenium-webdriver"

  # Code coverage [https://github.com/simplecov-ruby/simplecov]
  gem "simplecov", require: false
end