Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :items do
    resources :reservations
  end
  resources :reservations
end
