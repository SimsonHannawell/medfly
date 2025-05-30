class BasketsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Fetch baskets via orders
    @baskets = Basket.joins(:orders).where(orders: { user_id: current_user.id }).includes(:pharmacy)
  end

  def show
    @basket = current_user_basket

    if @basket.nil?
      redirect_to pharmacies_path, alert: 'No basket found for the current user.'
    else
      @basket_items = @basket.basket_items.includes(:product)
      @total_price = @basket_items.sum do |item|
        pharmacy_product = PharmacyProduct.find_by(pharmacy_id: @basket.pharmacy_id, product_id: item.product_id)
        product_price = pharmacy_product&.price || 0
        product_price * (item.quantity || 1)
      end
    end
  end

  def update
    @basket = current_user_basket
    if @basket&.update(basket_params)
      redirect_to basket_path(@basket), notice: 'Basket updated successfully.'
    else
      redirect_to basket_path(@basket), alert: 'Failed to update basket.'
    end
  end

  def destroy
    @basket = current_user_basket
    if @basket&.destroy
      redirect_to pharmacies_path, notice: 'Basket cleared successfully.'
    else
      redirect_to basket_path(@basket), alert: 'Failed to clear basket.'
    end
  end

def create
  @pharmacy = Pharmacy.find(params[:pharmacy_id])
  pharmacy_product = PharmacyProduct.find(params[:pharmacy_product_id])

  basket = current_user_basket

  unless basket
    order = current_user.orders.create!(delivered?: false)
    basket = order.create_basket(pharmacy_id: @pharmacy.id)
  end

  item = basket.basket_items.find_or_initialize_by(product_id: pharmacy_product.product_id)
  item.quantity += params[:quantity].to_i
  item.save!

  redirect_to pharmacy_path(@pharmacy), notice: "Item added to basket!"
end



  private

  def current_user_basket
    order = Order.where(user_id: current_user.id, delivered?: false).order(created_at: :desc).first
    order&.basket
  end

  def basket_params
    # Permit the basket attributes you want to allow for update here, e.g.:
    params.require(:basket).permit(:pharmacy_id)
  end
end
