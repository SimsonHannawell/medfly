class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.includes(:order_items)
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
      redirect_to order_path(@order), notice: 'Order placed successfully.'
    else
      render :new, alert: 'Failed to place order.'
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:shipping_address, :billing_address, :payment_method)
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
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
end
