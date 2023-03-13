Rails.application.routes.draw do
  namespace :external_coach do
    root "users#index"
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"


    # profileルーティング
    get "profile" => "profiles#show"

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
    root "home#index"
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"
  end

  #もういらなさそう↓
  #root "external_coach/home#index"
end
