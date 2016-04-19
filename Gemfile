source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'rails-api'
gem 'pg'
gem 'apartment'
gem 'pundit'
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'octokit', '~> 4.0'
gem 'rest-client'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'rubocop'
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'pry'
  gem 'annotate'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'vcr'
  gem 'json-schema'
end
