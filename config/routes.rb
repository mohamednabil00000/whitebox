Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[create show]
      post 'projects/:project_id/users/:user_id', to: 'projects#add_user'
    end
  end
end
