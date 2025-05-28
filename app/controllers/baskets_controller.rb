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
    # You need to create basket with pharmacy and order linking basket & user
    @basket = Basket.new(pharmacy: Pharmacy.first) # Example pharmacy, adjust as needed
    if @basket.save
      Order.create!(user: current_user, basket: @basket, delivered?: false)
      redirect_to basket_path(@basket), notice: 'Basket created successfully.'
    else
      redirect_to pharmacies_path, alert: 'Failed to create basket.'
    end
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

