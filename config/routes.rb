Rails.application.routes.draw do
  namespace :external_coach do
    root "home#index"
  end

  root "external_coach/home#index"
end
