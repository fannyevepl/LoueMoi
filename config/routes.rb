Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :items do
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, only: [:index, :show, :destroy] do
    collection do
      get :reservations_for_my_items
    end
  end
end
