source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '4.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 8.1.3'
# Use postgres as the database for Active Record
gem "airbrake"
gem "benchmark" #no longer included in ruby
gem 'bootstrap'
gem 'csv'
gem "importmap-rails"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails'
# sprockets is now optional
gem "sprockets"
gem 'stimulus-rails'
gem 'turbo-rails'

gem "friendly_id"

gem "devise"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:windows, :jruby]

# tokenizer
gem 'words_counted'

gem "aws-sdk-s3", require: false

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :windows]
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "dockerfile-rails"
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
end
