class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :confirm, :my_orders]

  def index
    base_scope = current_user.orders.includes(basket: { basket_items: :product })
    @orders = OrderFilterSorter.new(base_scope, params).call
  end

  def my_orders
    @user = current_user
    @active_order = @user.orders.find_by(status: 'active')
    @previous_orders = @user.orders.where.not(status: 'active').order(created_at: :desc)
    # Exclude active order from previous orders
    base_scope = @user.orders.where.not(id: @active_order&.id).includes(basket: { basket_items: :product })
    @orders = OrderFilterSorter.new(base_scope, params).call
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items.includes(:product)
  end

  def new
    @order = current_user.orders.new
    @basket_items = current_user.basket.basket_items.includes(:product) if current_user.basket
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.basket_items = current_user.basket.basket_items if current_user.basket

    if @order.save
      current_user.basket.basket_items.destroy_all if current_user.basket
      redirect_to confirm_order_path(@order), notice: 'Order placed successfully.'
    else
      render :new, alert: 'Failed to place order.'
    end
  end

  def confirm
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:shipping_address, :billing_address, :payment_method)
  end
end
