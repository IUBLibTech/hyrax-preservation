require 'rails_helper'

describe 'routes for Hyrax::Preservation::EventsController', type: :routing do
  routes { Hyrax::Preservation::Engine.routes }
  describe 'GET /events' do
    # TODO: The engine is mounted in the test app under '/preservation'. Is
    # there any way to test routes relative to the mount point?
    it 'routes to search interface for preservation events' do
      expect(get: '/events').to route_to(controller: 'hyrax/preservation/events', action: 'index')
    end
  end
end
