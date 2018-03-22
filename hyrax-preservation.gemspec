$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hyrax/preservation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hyrax-preservation"
  s.version     = Hyrax::Preservation::VERSION
  s.authors     = ["Andrew Myers"]
  s.email       = ["afredmyers@gmail.com"]
  s.summary     = "Preservation features for Hydra"
  s.description = "Hyrax Preservation provides models for storing and searching for preservation metadata."
  s.license     = "MIT"
  s.homepage    = 'https://github.com/IUBLibTech/hyrax-preservation'

  # Specify files that ship with the gem.
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # Exclude specific files that are only needed when developing the gem.
  s.files -= [
    'lib/tasks/preservation/ci.rake',
    'lib/tasks/preservation/services.rake',
    'lib/preservation/demo.rb',
    'lib/preservation/preservation_event_logger.rb'
  ]

  s.add_runtime_dependency 'hyrax', '~> 1.0', '>= 1.0.4'
  s.add_runtime_dependency 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'
  s.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.13'
  s.add_development_dependency 'rspec-rails', '~> 3.6', '>= 3.6.1'
  s.add_development_dependency 'capybara', '~> 2.15', '>= 2.15.1'
  s.add_development_dependency 'solr_wrapper', '~> 1.1', '1.1.0'
  s.add_development_dependency 'fcrepo_wrapper', '~> 0.8'
  s.add_development_dependency "factory_girl_rails", '~> 4.8', '>= 4.8.0'
  s.add_development_dependency 'pry-rails', '~> 0.3', '>= 0.3.6'
  s.add_development_dependency 'pry-byebug', '~> 3.6', '>= 3.6.0'
  s.add_development_dependency 'launchy', '~> 2.4', '>= 2.4.3'
  s.add_development_dependency 'rb-readline', '~> 0.5'
end
