Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "pages#home"

 # config/routes.rb

 # config/routes.rb

  get "pharmacy/menu", to: "pharmacy#menu"
  get "pharmacy/item", to: "pharmacy#item"
  get "pharmacy/discount", to: "pharmacy#discount"
  get "pharmacy/search", to: "pharmacy#search"
  get "pharmacy/my_profile", to: "pharmacy#my_profile"
  get "pharmacy/recieved_orders", to: "pharmacy#recieved_orders"
  get "pharmacy/warnings", to: "pharmacy#warnings"


  resources :pharmacy_items, only: [:new, :edit, :destroy]


  resources :pharmacies, only: [:index, :show] do
    resources :basket_items, only: [:create, :update, :destroy]
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
