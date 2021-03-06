source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 4.2.10'

gem 'active_model_serializers', '~> 0.8.3' # Because people hate 0.9.x branch for the different API, and 0.10.x is built on 0.8
gem 'activerecord-postgis-adapter'
gem 'geokit-rails' # Provides acts_as_mappable
gem 'gtfs'         # Support for General Transit Feed Specification (format of the stop/route data)
gem 'http'
gem 'kaminari'
gem 'pg'
gem 'puma'
gem 'rack-cors', require: 'rack/cors'
gem 'redis'
gem 'redis-store', '~> 1.4.0' # http://www.cvedetails.com/cve/CVE-2017-1000248/
gem 'redis-rails', '~> 5.0'   # For using Redis as the application cache
gem 'rgeo-geojson'
gem 'ruby-protocol-buffers' # Required for parsing GTFS data which is built in protocol buffers
gem 'sentry-raven'          # Error reporting service
gem 'skylight'              # Profiling and performance monitoring

group :development do
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'simplecov', require: false
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
  gem 'uglifier'
end
