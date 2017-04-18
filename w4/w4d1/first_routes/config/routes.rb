Rails.application.routes.draw do
  resources :users, only: [:create, :destroy, :index, :show, :update]
  resources :artworks, only: [:create, :destroy, :index, :show, :update]
  resources :artwork_shares, only: [:create, :destroy]
  resources :comments, only: [:index, :create, :destroy]
end
