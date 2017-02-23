$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gorg_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gorg_engine"
  s.version     = GorgEngine::VERSION
  s.authors     = ["Alexandre Narbonne"]
  s.email       = ["alexandre.narbonne@gadz.org"]
  s.homepage    = "https://github.com/Zooip/GorgEngine"
  s.summary     = "Rails Engine for Gorg apps"
  s.description = "Rails Engine for Gorg apps"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.0"
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

  s.add_development_dependency "sqlite3"
end
