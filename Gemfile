source 'https://rubygems.org'

ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.1'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

#FOR MAILGUN
gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun'


# Use Haml as the templating library
gem 'haml'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
gem 'activeadmin', github: 'activeadmin'
gem "activeadmin_polymorphic"
gem 'rolify'

gem 'whenever', :require => false
gem 'rufus-scheduler'

gem 'bootstrap_form'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
#gem 'spring'

# Call 'byebug' anywhere in the code to stop execution and get a debugger console
gem 'byebug'
gem 'rspec-rails'
gem 'guard-rspec'

gem 'cucumber-rails', :require => false
gem 'capybara'
gem 'rspec'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  
  gem 'actionmailer'
  gem 'quiet_assets'
  gem "awesome_print", require:"ap"
  gem "better_errors"
end

group :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :production do
  gem 'pg' # for Heroku deployment
  gem 'rails_12factor'
end
