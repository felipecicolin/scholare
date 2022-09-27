# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :users, except: %i[index new edit create show update destroy] do
    resources :school_classes, except: :show
  end

  resources :students, except: :show do
    get :find_school_classes
  end
end
