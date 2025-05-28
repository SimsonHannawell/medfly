Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "pages#home"

  resources :pharmacies, only: [:index, :show] do
    resources :basket_items, only: [:create, :update, :destroy]
     resources :reviews, only: [:new, :create]
  end

  resources :baskets, only: [:create, :update, :show, :destroy] do
    resources :orders, only: [:create, :show]
  end

  resources :orders, only: [:index]
  resources :users, only: [:edit, :update]

  resources :pharmacies, only: [:new, :edit] do
    resources :pharmacy_products, only: [:create, :update, :destroy]
  end

  resources :favourites, only: [:create, :index]

end
