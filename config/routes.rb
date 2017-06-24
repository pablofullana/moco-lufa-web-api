Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get :server_setup, to: 'static#server_setup'
      get :stats, to: 'static#stats'
      resources :firmwares, only: [:index, :create]
    end
  end
end
