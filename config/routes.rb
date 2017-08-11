Rails.application.routes.draw do
  resources :exchange_combinations
  devise_for :users
  root 'exchange_combinations#index'
end
