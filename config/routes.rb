# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :school_classes
  resources :students
end
