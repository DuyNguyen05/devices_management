# frozen_string_literal: true

Rails.application.routes.draw do
  get "pages/home"
  # get "login" => "sessions#new"
  # post "login" => "sessions#create"
  # delete "logout" => "sessions#destroy"
  root "pages#home"
  get '/login', to: 'sessions#new', as: 'login'
  get '/oauth2callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :devices
  resources :users
end
