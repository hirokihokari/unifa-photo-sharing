Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :photos, only: %i(index new create)

  get '/oauth/callback', as: :oauth_callback

  root "photos#index"
end
