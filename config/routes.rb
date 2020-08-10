Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/purchase_history'
  get 'pages/remove_account'
  get 'assets/payment_success'
  get 'assets/payment_failed'
  root 'pages#home'
  resources :assets
  devise_for :users
end
