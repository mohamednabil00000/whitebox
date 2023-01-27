Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
    end
  end
end
