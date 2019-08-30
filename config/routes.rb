# frozen_string_literal: true

Rails.application.routes.draw do
  root "pages#home"

  get "pages/home"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "/auth",to: "sessions#create"
  resources :devices
  resources :users
end
