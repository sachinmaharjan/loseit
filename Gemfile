source 'http://rubygems.org'

gem 'haml', '3.1.4'
gem 'rails', '3.0.11'
gem 'rake', '0.8.7'
gem 'sass', "3.1.2"
gem 'gravatar_image_tag'
gem 'json'
gem 'jquery-rails'


group :development do
  gem 'heroku', '2.3.0'
  gem 'sqlite3'
  gem 'ruby-debug', '0.10.4'
end

group :development, :test do
  gem 'fixture_builder'
  gem 'jasmine', '1.1.0'
  gem 'jasmine-fixtures', '0.1.6', :git => "https://github.com/pivotal-casebook/jasmine-fixtures.git"
  gem 'rspec-rails', '2.5.0'
  gem 'rspec', '2.5.0'
end

group :development, :test, :staging do
  gem 'mail_safe', '0.3.1'
end

group :test do
  gem 'factory_girl_rails', '1.0.1'
  gem 'faker', '0.9.5'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
