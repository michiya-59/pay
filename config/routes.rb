# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    post :user_confirm, action: :user_confirm_new, on: :new
    resources :suppliers do
      post :suppliers_confirm, action: :supplier_confirm_new, on: :new
      member do
        post :suppliers_confirm_edit, action: :suppliers_confirm_edit
      end
    end
  end
end
