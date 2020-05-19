Rails.application.routes.draw do
  resources :weapons
  resources :users, only: [:index, :create]
  resources :enemies, only: [:update, :destroy]
end
