class BasketItemsController < ApplicationController
  def create
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
    @basket_item = @pharmacy.basket_items.new(basket_item_params)
    @basket_item.user = current_user

    if @basket_item.save
      redirect_to pharmacy_path(@pharmacy), notice: 'Item added to basket.'
    else
      redirect_to pharmacy_path(@pharmacy), alert: 'Failed to add item to basket.'
    end
  end

  def update
    @basket_item = BasketItem.find(params[:id])
    if @basket_item.update(basket_item_params)
      redirect_to pharmacy_path(@basket_item.pharmacy), notice: 'Basket item updated successfully.'
    else
      redirect_to pharmacy_path(@basket_item.pharmacy), alert: 'Failed to update basket item.'
    end
  end

  def destroy
    @basket_item = BasketItem.find(params[:id])
    @pharmacy = @basket_item.pharmacy
    if @basket_item.destroy
      redirect_to pharmacy_path(@pharmacy), notice: 'Item removed from basket.'
    else
      redirect_to pharmacy_path(@pharmacy), alert: 'Failed to remove item from basket.'
    end
  end

  private

  def basket_item_params
    params.require(:basket_item).permit(:product_id, :quantity)
  end

  def current_user
    # Assuming you have a method to get the current user, e.g., from Devise
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: 'You need to sign in or sign up before continuing.'
    end
  end

  before_action :authenticate_user!, only: [:create, :update, :destroy]
end
