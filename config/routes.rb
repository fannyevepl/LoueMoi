Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :items do
    resources :reservations, only: [:new, :create]
  end
  resources :reservations, only: [:index, :show, :destroy]
end
