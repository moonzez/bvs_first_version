Rails.application.routes.draw do

  get 'login', :to => 'user_sessions#new', :as => 'login'
  get 'logout', :to => 'user_sessions#destroy', :as => 'logout'

  root :to => 'users#home'

  resources :users
  resources :referents

  resources :user_sessions

  resources :languages

  resources :roles

  resources :licenses

end
