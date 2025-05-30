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
    basket = current_user.orders.find_by(delivered?: false)&.basket

    if basket.nil? || basket.basket_items.empty?
      redirect_to pharmacies_path, alert: 'No active basket to place order.'
      return
    end

    @order = current_user.orders.new(order_params)
    @order.basket = basket

    if @order.save
      # Mark order as delivered? or update status accordingly
      @order.update(delivered?: true, status: 'active')

      # Destroy basket as order placed
      basket.destroy

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
