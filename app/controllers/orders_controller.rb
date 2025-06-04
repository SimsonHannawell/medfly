class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    base_scope = current_user.orders.includes(basket: { basket_items: :product })
    @orders = OrderFilterSorter.new(base_scope, params).call
  end

  def my_orders
    @user = current_user
    @active_order = @user.orders.find_by(status: 'active')
    @previous_orders = @user.orders.where.not(status: 'active').order(created_at: :desc)
    base_scope = @user.orders.where.not(id: @active_order&.id).includes(basket: { basket_items: :product })
    @orders = OrderFilterSorter.new(base_scope, params).call
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items.includes(:product)
  end

  def create
    @basket = Basket.find(params[:basket_id])
    @order = Order.new
    @order.basket = @basket
    @order.user = current_user

    if @order.save
      redirect_to confirm_order_path(@order), notice: 'Order placed successfully.'
    else
      render "baskets/show", alert: 'Failed to place order.'
    end
  end

  def confirm
    @order = Order.find(params[:id])
    @pharmacy = @order.basket.pharmacy
    @total_price = @order.basket.basket_items.sum do |item|
      product_price(item)
    end
  end


  def product_price(item)
    @pharmacy_product = PharmacyProduct.find_by(pharmacy: @pharmacy, product: item.product)
    @pharmacy_product.price * item.quantity
  end

end
