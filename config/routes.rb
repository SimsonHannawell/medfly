Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  # Frontend routes for regular users
  resources :pharmacies, only: [:index, :show] do
    resources :basket_items, only: [:create, :update, :destroy]
  end

  resources :baskets, only: [:create, :update, :show, :destroy] do
    resources :orders, only: [:create, :show]
  end

  resources :orders, only: [:index]
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

