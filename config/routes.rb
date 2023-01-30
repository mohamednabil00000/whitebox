Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[create show]
      resources :tasks, only: %i[create show]

      post 'projects/:project_id/users/:user_id', to: 'projects#add_user'
      delete 'projects/:project_id/users/:user_id', to: 'projects#remove_user'

      post 'tasks/:task_id/users/:user_id', to: 'tasks#assign_user'
      delete 'tasks/:task_id/remove_assign', to: 'tasks#remove_assigning_user'
    end
  end
end
