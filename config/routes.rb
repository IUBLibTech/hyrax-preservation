Hyrax::Preservation::Engine.routes.draw do
  resources :events, only: [:index, :show]
end
