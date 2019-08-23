Rails.application.routes.draw do

  get 'pages/home'
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  delete 'logout' => "sessions#destroy"
  root 'pages#home'

  resources :devices
  resources :users
end
