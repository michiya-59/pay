# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users do
    post :user_confirm, action: :user_confirm_new, on: :collection
  end
end
