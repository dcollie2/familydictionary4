source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.7.2'
# Use postgres as the database for Active Record
gem "airbrake"
gem 'bootstrap'
# hotwire for messaging
gem 'hotwire-rails'

gem "importmap-rails"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use SCSS for stylesheets
gem 'sass-rails'
# sprockets is now optional
gem "sprockets"
gem 'stimulus-rails'
# Turbo for interactivity without page refresh
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbo-rails'

gem "friendly_id"

gem "devise"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# tokenizer
gem 'words_counted'

gem "aws-sdk-s3", require: false

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "dockerfile-rails"
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen'
  gem 'rack-mini-profiler'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
