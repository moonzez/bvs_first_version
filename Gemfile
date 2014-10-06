source 'https://rubygems.org'

gem 'rails', '4.1.5'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'authlogic'
gem 'scrypt'

group :development do
  gem 'spring'
  # checking code quality
  gem 'reek'
  gem 'rails_best_practices'
  gem 'rubocop', require: false
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test, :development do
  gem 'pry'
  gem 'rspec-rails'
  gem 'launchy'
end

group :test do
  gem 'faker'
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'factory_girl'
  gem 'simplecov', require: false
  gem 'selenium-webdriver'
end
