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

  resources :pharmacy_items, only: [:new, :edit, :destroy]

  # Regular user-facing features

  resources :pharmacies, only: [:index, :show] do
    resources :basket_items, only: [:create, :update, :destroy]
    resources :reviews, only: [:new, :create]
  end

  resources :baskets, only: [:show, :update, :destroy] do
    resources :orders, only: [:create, :show]
  end

  resources :orders, only: [:index] do
    member do
      get :confirm
    end
  end

  resources :users, only: [:edit, :update]
  resources :favourites, only: [:create, :index]

  resources :basket_items, only: [:destroy] do
    member do
      patch :update_quantity
    end
  end

  namespace :pharmacist do
    root to: "dashboard#index"
    resources :pharmacies, only: [:new, :edit, :create, :update, :destroy] do
      resources :pharmacy_products, only: [:create, :update, :destroy]
    end
  end
end
