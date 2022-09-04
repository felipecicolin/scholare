# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  resources authentication, only: :create
end
