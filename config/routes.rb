# frozen_string_literal: true

Rails.application.routes.draw do
  get "pages/home"
  root "pages#home"
  get '/login', to: 'sessions#new', as: 'login'
  get '/oauth2callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :devices
  resources :users
end
