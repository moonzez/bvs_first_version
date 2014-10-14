Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new', as: 'login'
  post 'login', to: 'user_sessions#create', as: 'post_login'

  get 'logout', to: 'user_sessions#destroy', as: 'logout'

  root to: 'users#home'

  namespace :admin do
    resources :users, except: [:show]
  end

  resources :referents, except: [:show, :destroy] do
    collection do
      get :inactiv
    end
    member do
      delete :remove
      put :change_activ
    end
  end

  resources :user_sessions, except: [:update, :edit, :show, :index]

  resources :languages, except: [:new, :update, :edit, :show]

  resources :licenses, except: [:new, :update, :edit, :show]

  resource :profile, only: [:edit, :update]
end
