# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :school_classes, except: :show
  resources :students, except: :show

  resources :tests, except: :show do
    resources :questions, except: :show
  end

  namespace :pdf do
    resources :tests, only: :index
    resources :feedbacks, only: :index
  end
end
