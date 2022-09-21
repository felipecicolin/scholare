# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  as :user do
    root to: "panel#index", as: :authenticated_root
  end

  resources :panel, only: :index
end
