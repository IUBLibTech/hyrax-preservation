require 'preservation/service_environment'
require 'rspec/core/rake_task'

namespace :preservation do
  task :ci => ['engine_cart:generate'] do
    Preservation::ServiceEnvironment.new('test').wrap do
      RSpec::Core::RakeTask.new(:spec)
      Rake::Task['spec'].invoke
    end
  end
end
