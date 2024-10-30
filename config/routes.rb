Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'about' => 'pages#about'

  resources :items do
    resources :reservations
  end
  resources :reservations
  
  # Route pour gérer les erreurs 404
  match '*path', to: 'errors#error404', via: :all
end
