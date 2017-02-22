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

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "sqlite3"
end
