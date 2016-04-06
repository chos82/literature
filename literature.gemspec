$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "literature/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "literature"
  s.version     = Literature::VERSION
  s.authors     = [""]
  s.email       = ["christopher.ossner2@kit.edu"]
  s.homepage    = "http://www.chemotion.net/"
  s.summary     = "Manages references for chemotion"
  s.description = "Manages references for chemotion"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "oauth"
  s.add_dependency "bibtex-ruby"

  s.add_development_dependency "sqlite3"
end
