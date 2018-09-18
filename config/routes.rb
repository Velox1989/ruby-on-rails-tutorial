Rails.application.routes.draw do


  root 'static_pages#home'
  get 'static_pages/home'
  get  'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  # get  '/contact', to: 'static_pages#contact'
  # get  'users/new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'


  resources :users

end
