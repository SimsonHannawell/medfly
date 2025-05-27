class BasketsController < ApplicationController
  def show
    @basket = current_user.basket
    if @basket.nil?
      redirect_to pharmacies_path, alert: 'No basket found. Please add items to your basket.'
    else
      @basket_items = @basket.basket_items.includes(:product)
    end
  end
  
  def update
    @basket = current_user.basket
    if @basket.update(basket_params)
      redirect_to basket_path(@basket), notice: 'Basket updated successfully.'
    else
      redirect_to basket_path(@basket), alert: 'Failed to update basket.'
    end
  end

  def destroy
    @basket = current_user.basket
    if @basket.destroy
      redirect_to pharmacies_path, notice: 'Basket cleared successfully.'
    else
      redirect_to basket_path(@basket), alert: 'Failed to clear basket.'
    end
  end

  def create
    @basket = current_user.build_basket
    if @basket.save
      redirect_to basket_path(@basket), notice: 'Basket created successfully.'
    else
      redirect_to pharmacies_path, alert: 'Failed to create basket.'
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
  before_action :authenticate_user!, only: [:show]
end
