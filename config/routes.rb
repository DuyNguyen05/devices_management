# frozen_string_literal: true

Rails.application.routes.draw do

  root "pages#home"

  get "pages/home"
  root "pages#home"
  get '/oauth2callback', to: 'google#create'
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  scope "/auth" do
    get "github/callback", to: "github#create"
  end
  resources :devices
  resources :requests, except: [:show, :destroy]
  resources :users
end
