$:.push File.expand_path("../lib", __FILE__)

# Maintain your s.add_development_dependency " version"
require "gorg_engine/version"

# Describe your s.add_development_dependency "nd declare its dependencies"
Gem::Specification.new do |s|
  s.name        = "gorg_engine"
  s.version     = GorgEngine::VERSION
  s.authors     = ["Dorian Becker"]
  s.email       = ["dorian.becker@gadz.org"]
  s.homepage    = "https://github.com/gadzorg/GorgEngine"
  s.summary     = "Rails Engine for Gorg apps"
  s.description = "Rails Engine for Gorg apps"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.8"

  #############################################################
  ## UI
  #############################################################
  s.add_dependency "materialize-sass", "~> 0.98.0"

  # Use SCSS for stylesheets
  s.add_dependency "sass-rails", "~> 5.0"

  # Use Uglifier as compressor for JavaScript assets
  s.add_dependency "uglifier", ">= 1.3.0"

  # Use jquery as the JavaScript library
  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"

  s.add_dependency "unobtrusive_flash", ">=3"
  s.add_dependency "haml-rails", "~> 0.9"

  #form
  s.add_dependency 'simple_form'
  s.add_dependency 'virtus'

  s.add_dependency 'will_paginate', '~> 3.0.0'

  #############################################################
  ## back
  #############################################################

  # Authentification
  s.add_dependency 'devise', '~> 4.1.1'
  s.add_dependency 'omniauth'
  s.add_dependency 'devise_masquerade'

  # Authorisations
  s.add_dependency 'cancancan'


  #############################################################
  ## Gorg
  #############################################################

  #Slack chat
  s.add_dependency 'gorg_slack_chat'

  #Gram API Client
  s.add_dependency 'gram_v2_client'

  s.add_dependency "mysql2"

  #############################################################
  ## dev
  #############################################################
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "better_errors"
  s.add_development_dependency "binding_of_caller"
  s.add_development_dependency "byebug"
  s.add_development_dependency "squasher"
  s.add_development_dependency "rack-mini-profiler"

  # tests
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "faker"
  s.add_development_dependency "shoulda-matchers", "~> 3.0"
  s.add_development_dependency "database_cleaner"

end