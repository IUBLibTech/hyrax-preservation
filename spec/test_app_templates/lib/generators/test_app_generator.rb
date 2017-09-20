require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root File.join(Hyrax::Preservation.root, "spec", "test_app_templates")

  def install_hyrax
    generate 'hyrax:install -f'
  end

  def install_engine
    generate 'hyrax:preservation:install'
  end
end
