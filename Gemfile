source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '4.0.0.alpha6'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'popper_js', '~> 1.12.3'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.6'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'travis'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'font-awesome-rails'

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop'
  gem 'capybara'
  gem 'database_cleaner'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>=1.3.3'
end
