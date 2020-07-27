Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/about'
  get 'pages/contact'
  root 'pages#home'
  resources :assets
  devise_for :users
end
