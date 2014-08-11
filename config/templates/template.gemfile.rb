source 'https://rubygems.org'

gem 'dirt', path: '../dirt/'

group :development do
  gem 'simplecov'
end

group :test do
  gem 'rspec'
  gem 'cucumber'
  gem 'capybara'
  gem 'launchy'

  gem 'factory_girl', '~> 4.0'
  gem 'parallel_tests'
end