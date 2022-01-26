# frozen_string_literal: true

Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :suppliers, only: [:index]
  resources :users do
    get 'main'
    get 'sub'

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

    resources :incomes do
      collection do
        get 'shows'
      end
      member do
        post :income_confirm_edit, action: :income_confirm_edit
      end
    end

    resources :expenses do
      collection do
        get 'shows'
      end
      member do
        post :expense_confirm_edit, action: :expense_confirm_edit
      end
    end
  end
end
