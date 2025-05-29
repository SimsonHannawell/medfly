Rails.application.routes.draw do

  # Devise user authentication
  devise_for :users

  # Root path
  root to: "pages#home"

  # Health check
  get "up", to: "rails/health#show", as: :rails_health_check

  # User account page
  get "/users/my_account", to: "users#account", as: :my_account




 # config/routes.rb

  get "pharmacy/menu", to: "pharmacy#menu"
  get "pharmacy/item", to: "pharmacy#item"
  get "pharmacy/discount", to: "pharmacy#discount"
  get "pharmacy/search", to: "pharmacy#search"
  get "pharmacy/my_profile", to: "pharmacy#my_profile"
  get "pharmacy/recieved_orders", to: "pharmacy#recieved_orders"
  get "pharmacy/warnings", to: "pharmacy#warnings"
  get 'orders/my_orders', to: 'orders#my_orders', as: 'my_orders'


  resources :pharmacy_items, only: [:new, :edit, :destroy]



  # Regular user-facing features

  resources :pharmacies, only: [:index, :show] do
    resources :basket_items, only: [:create, :update, :destroy]
     resources :reviews, only: [:new, :create]
  end

  resources :baskets, only: [:create, :update, :show, :destroy] do
    resources :orders, only: [:create, :show]
  end

  resources :orders, only: [:index] do
    member do
      get :confirm   # /orders/:id/confirm
    end
  end

  resources :users, only: [:edit, :update]
  resources :favourites, only: [:create, :index]

  # Pharmacist backend namespace
  namespace :pharmacist do
    root to: "dashboard#index"

    resources :pharmacies, only: [:new, :edit, :create, :update, :destroy] do
      resources :pharmacy_products, only: [:create, :update, :destroy]
    end
  end
end
