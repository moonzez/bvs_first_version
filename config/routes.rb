Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new', as: 'login'
  get 'logout', to: 'user_sessions#destroy', as: 'logout'

  root to: 'users#home'

  resources :users, except: [:show]

  resources :referents, except: [:new, :create, :edit, :update, :show, :destroy]

  resources :user_sessions, except: [:update, :edit, :show, :index]

  resources :languages, except: [:new, :update, :edit, :show]

  # resources :roles

  resources :licenses, except: [:new, :update, :edit, :show]
end
