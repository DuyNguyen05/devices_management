# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.1"

gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "dotenv-rails", groups: [:development, :test]
gem "faker"
gem "haml-rails"
gem "httparty"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "json"
gem "mysql2"
gem "oauth2"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "json"
gem "dotenv-rails"
gem "httparty"
gem "kaminari"
gem "bootstrap4-kaminari-views"


group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-github"
end

group :development do

  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
