source 'https://rubygems.org'

# Declare your gem's dependencies in gorg_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
gem 'simple_form-materialize', github: 'patricklindsay/simple_form-materialize'
gem 'configurable_engine', github: 'Blaked84/configurable_engine'

gem "omniauth-cas", :git => "https://github.com/gadzorg/omniauth-cas.git", :branch => 'saml'

gem "awesome_print", require:"ap"

gem 'heroku_secrets', github: 'alexpeattie/heroku_secrets'


group :test, :development do
  gem "simplecov"
  gem "codeclimate-test-reporter", "~> 1.0.0"
end