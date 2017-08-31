module Hyrax::Preservation
  class Engine < ::Rails::Engine
    isolate_namespace Hyrax::Preservation

    config.autoload_paths += %W(
      #{config.root}/app/helpers
      #{config.root}/app/indexers
      #{config.root}/app/presenters
      #{config.root}/app/search_builders
      #{config.root}/lib/preservation
    )
  end
end
