class FavouritesController < ApplicationController
  def index
    @favourites = current_user.favourites.includes(:product)
  end

  def create
    @product = Product.find(params[:product_id])
    @favourite = current_user.favourites.new(product: @product)

    if @favourite.save
      redirect_to favourites_path, notice: 'Product added to favourites.'
    else
      redirect_to product_path(@product), alert: 'Failed to add product to favourites.'
    end
  end

  private
  def current_user
    # Assuming you have a method to get the current user, e.g., from Devise
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: 'You need to sign in or sign up before continuing.'
    end
  end

  before_action :authenticate_user!, only: [:index, :create]
  def favourite_params
    params.require(:favourite).permit(:product_id)
  end
  
end
