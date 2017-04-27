$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "preservation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "preservation"
  s.version     = Preservation::VERSION
  s.authors     = ["Andrew Myers"]
  s.email       = ["afredmyers@gmail.com"]
  s.summary = "Preservation features for Hydra"
  s.description = "Preservation features for Hydra"
  s.license     = "MIT"

  # Specify files that ship with the gem.
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # Exclude specific files that are only needed when developing the gem.
  s.files -= [
    'lib/tasks/preservation/ci.rake',
    'lib/tasks/preservation/services.rake',
    'lib/preservation/demo.rb',
    'lib/preservation/preservation_event_logger.rb'
  ]

  s.add_dependency "hyrax"
  # TODO: We can remove the pinned jquery-ui-rails dep here after upgrading to
  # curation_concerns 1.7.0
  s.add_dependency "jquery-ui-rails", "~> 5.0.5"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'solr_wrapper'
  s.add_development_dependency 'fcrepo_wrapper'
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'rb-readline'
end
