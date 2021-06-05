Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'log', to: 'users#log'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'oauth_login', to: redirect('/auth/google_oauth2'), as: 'oauth_login'
  get '/auth/:provider/callback', :to => 'sessions#oauth'

  resources :categories
end
