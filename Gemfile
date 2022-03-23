# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0', '>= 7.0.1'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false
# Code coverage
gem 'simplecov', require: false, group: :test
gem 'simplecov-json', :require => false, :group => :test
gem 'parallel_tests', group: [:development, :test]
# Authenticate
gem 'devise'
gem 'devise_token_auth', '>= 1.2.0', git: 'https://github.com/lynndylanhurley/devise_token_auth'

# Serializer
gem 'jsonapi-serializer'

# multi_json
gem 'multi_json', '~> 1.11', '>= 1.11.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Rspec TDD
  gem 'rspec-rails'
  # Create entities
  gem 'factory_bot_rails'
  # Fake entities creation
  gem 'faker'
  # Clean database before testing
  gem 'database_cleaner-active_record'
  # Validate api json returns
  gem 'json-schema'
  # Validate uniquess and presence
  gem 'shoulda-matchers'
  # RSpec formatters
  gem 'rspec-sonarqube-formatter', '~> 1.5', require: false
  # Deployment
  gem 'capistrano', '~> 3.16', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  # integrate bundler with capistrano
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  # gem 'capistrano-foreman', github: 'koenpunt/capistrano-foreman'

  # Ed25519 keys support
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'ed25519', '>= 1.2', '< 2.0'
  # Security tests
  gem 'brakeman'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rubocop'
  # Annotation
  gem 'annotate'
end

group :test do
  gem 'rspec'
  gem 'rspec_junit_formatter'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
