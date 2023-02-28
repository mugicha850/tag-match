Rails.application.routes.draw do
  namespace :external_coach do
    root "home#index"
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"

    get "test" => "home#test"

    # profileルーティング
    get "profile" => "profiles#show"

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
