source 'http://rubygems.org'

gem 'rails', '>= 3.1'

# XXX you should force the version number to prevent confusing breaks
gem 'sqlite3', '>= 1.3.3'
gem 'sqlite3-ruby', '>= 1.3.3'

gem 'gravatar_image_tag'
gem 'will_paginate', '>=3.0.pre2'

gem 'haml', '>= 3.0.25'
gem 'compass', '>= 0.10.6'

# XXX all groups need faker because of sample_data.rake
gem 'faker'

group :development do
  gem "capistrano"
  gem 'rspec-rails'
  gem 'annotate'
end

group :test do
  gem 'rspec'
  gem 'webrat'
  gem 'spork'
  gem 'factory_girl_rails'
end

group :production do
  gem 'pg'
  gem 'memcache-client'
end
