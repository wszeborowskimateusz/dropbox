Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  get '/attachments/new', to: 'attachments#new', as: :new_attachment
  post '/attachments', to: 'attachments#create', as: :attachments

  # Defines the root path route ("/")
  root 'attachments#index'
end
