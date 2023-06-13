# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :school_classes, except: :show
  resources :students, except: :show

  resources :tests, except: :show

  namespace :pdf do
    resources :tests, only: :index
    resources :templates, only: :index
  end

  namespace :api do
    resources :test_grades, only: :create

    post "/mobile_login", to: "mobile_sessions#create"
    post "/is_user_logged_in", to: "mobile_sessions#show"
    delete "/mobile_logout", to: "mobile_sessions#destroy"
  end
end
