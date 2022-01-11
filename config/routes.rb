# frozen_string_literal: true

Rails.application.routes.draw do
  get 'incomes/index'
  get 'incomes/new'
  get 'incomes/create'
  get 'incomes/edit'
  get 'incomes/destroy'
  get 'incomes/show'
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
    resources :expense_categories do
      post :expense_categories_confirm, action: :expense_categories_confirm_new, on: :new
      member do
        post :expense_categories_confirm_edit, action: :expense_categories_confirm_edit
      end
    end
  end
end
