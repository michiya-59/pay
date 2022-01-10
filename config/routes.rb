# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :suppliers, only: [:index]
  resources :users do
    resources :suppliers, only: %i[show edit update destroy new create] do
      post :suppliers_confirm, action: :supplier_confirm_new, on: :new
      member do
        post :suppliers_confirm_edit, action: :suppliers_confirm_edit
      end
    end
    post :user_confirm, action: :user_confirm_new, on: :new
    resources :expense_categories
  end
end
