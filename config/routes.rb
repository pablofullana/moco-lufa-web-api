Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get :info, to: 'static#info'
      resources :firmwares, only: :create
    end
  end
end
