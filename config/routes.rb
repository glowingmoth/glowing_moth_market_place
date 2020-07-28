Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/remove_account'
  root 'pages#home'
  resources :assets
  devise_for :users
end
