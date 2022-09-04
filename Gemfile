# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip

gem "goldiloader"
gem "pg"
gem "puma"
gem "rails"
gem "simple_form"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "view_component"
gem "vite_rails"

group :development do
  gem "better_errors"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :development, :test do
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "parallel_tests"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "shoulda-matchers"
end
