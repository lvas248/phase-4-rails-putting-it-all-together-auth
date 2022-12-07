Rails.application.routes.draw do
  
  #new user signup
  post '/signup', to: 'users#create'

  # user stays logged in when page is refreshed
  get '/me', to: 'users#show'

  # user login  
  post '/login', to: 'sessions#create'

  # user logout
  delete '/logout', to: 'sessions#destroy'

  #recipe list feature
  resources :recipes, only: [:index, :create]
end
