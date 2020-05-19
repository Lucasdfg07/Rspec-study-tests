Rails.application.routes.draw do
  resources :weapons
 resources :users, only: [:index, :create]
end
