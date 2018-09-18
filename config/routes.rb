Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home'
  get 'static_pages/home'
  get  'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  # get  '/contact', to: 'static_pages#contact'
  # get  'users/new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get '/login', to: 'sessions#new'          # page for a session
  post '/login', to: 'sessions#create'      # create a session
  delete '/logout', to: 'sessions#destroy'  # delete a session

  resources :users

end
