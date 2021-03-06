source 'https://rubygems.org'
ruby "2.2.0"
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Twitter bootstrap
gem 'bootstrap-sass'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Haml support
gem 'haml'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# NullObject
gem 'naught'

# Multi-step form
gem 'wicked'

# Upload
gem 'carrierwave'
gem 'fog', require: 'fog/aws/storage'
gem 'carrierwave_direct', github: 'sevos/carrierwave_direct', branch: 'patch-1'

# Loads environment variables from .env file
gem 'dotenv'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Heroku
gem 'rails_12factor'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Test framework
  gem 'rspec-rails'

  # Rspec command for Spring
  gem "spring-commands-rspec"

  # Full stack testing
  gem "capybara"

  # Headless testing
  gem 'capybara-webkit'
  gem 'selenium-webdriver'

  # Database cleaner
  gem 'database_cleaner'
end
