require 'hyrax/preservation/service_environment'

namespace :services do
  task :start, [:env] do |t, args|
    env = args[:env] || 'development'
    Hyrax::Preservation::ServiceEnvironment.new(env).start
  end
end
