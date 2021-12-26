# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :suppliers

  resources :users do
    post :user_confirm, action: :user_confirm_new, on: :new
  end
end
