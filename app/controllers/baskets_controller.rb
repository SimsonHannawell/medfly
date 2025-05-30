class BasketsController < ApplicationController
  before_action :authenticate_user!

  def show
    @basket = current_user_active_basket

    if @basket.nil?
      redirect_to pharmacies_path, alert: 'No active basket found.'
    else
      @basket_items = @basket.basket_items.includes(:product)
      @total_price = @basket_items.sum do |item|
        pharmacy_product = PharmacyProduct.find_by(pharmacy_id: @basket.pharmacy_id, product_id: item.product_id)
        (pharmacy_product&.price || 0) * (item.quantity || 1)
      end
    end
  end

  def update
    @basket = current_user_active_basket
    if @basket&.update(basket_params)
      redirect_to basket_path(@basket), notice: 'Basket updated successfully.'
    else
      redirect_to basket_path(@basket), alert: 'Failed to update basket.'
    end
  end

  def destroy
    @basket = current_user_active_basket
    if @basket&.destroy
      redirect_to pharmacies_path, notice: 'Basket cleared successfully.'
    else
      redirect_to basket_path(@basket), alert: 'Failed to clear basket.'
    end
  end

  private

  def basket_params
    params.require(:basket).permit(:pharmacy_id)
  end

  def current_user_active_basket
    # Find current user's undelivered order's basket
    order = current_user.orders.find_by(delivered?: false)
    order&.basket
  end
end
