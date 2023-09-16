Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  namespace :external_coach do
    root "users#index"
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"


    # profileルーティング
    resource :profile

    # userルーティング
    resources :users

    # 記事
    resources :articles

    # accountルーティング
    resource :account, only: [:show, :edit, :update]

    # passwordルーティング
    resource :password, only: [:show, :edit, :update]
  end

  namespace :club_advisor do
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"

    root "articles#index"

    # 記事
    resources :external_coaches 
    resources :articles

    # accountルーティング
    resource :account, only: [:show, :edit, :update]

    # userルーティング
    resources :users
    
    # profileルーティング
    resource :profile

    # passwordルーティング
    resource :password, only: [:show, :edit, :update]
  end
end
