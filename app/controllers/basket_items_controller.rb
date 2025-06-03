class BasketItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pharmacy
  before_action :set_basket_item, only: [:update, :destroy]

  def create
  #   order = current_user.orders.find_or_create_by!(pharmacy: @pharmacy, delivered?: false)
  #   basket = order.basket || order.create_basket(pharmacy: @pharmacy)

  #   basket_item = basket.basket_items.find_or_initialize_by(product_id: params[:product_id])
  #   basket_item.quantity += params[:quantity].to_i
  #   basket_item.save!

  #   # Recalculate total using pharmacy_products pricing
  #   total_price = basket.basket_items.joins("INNER JOIN pharmacy_products ON pharmacy_products.product_id = basket_items.product_id AND pharmacy_products.pharmacy_id = #{basket.pharmacy_id}")
  #                                    .sum("pharmacy_products.price * basket_items.quantity")

  #   render json: {
  #     success: true,
  #     total_price: total_price,
  #     basket_id: basket.id
  #   }
  # rescue => e
  #   Rails.logger.error("BasketItems#create error: #{e.message}")
  #   render json: { error: e.message }, status: :unprocessable_entity
  @pharmacy = Pharmacy.find(params[:pharmacy_id])

  @basket = @pharmacy.baskets.last || Basket.new(pharmacy: @pharmacy)
  @basket.pharmacy = @pharmacy
  @basket_item = @basket.basket_items.find_or_initialize_by(product_id: params[:basket_item][:product_id])

  @basket_item.quantity = params[:basket_item][:quantity]

    @total_price = @basket.basket_items.sum do |item|
      product_price(item)
    end
    if @basket_item.save
      redirect_to basket_path(@basket), notice: "Item added to basket."
    else
      redirect_to pharmacy_path(@pharmacy), alert: "Failed to add item to basket."
    end
  end

 def update
  @basket_item = BasketItem.find(params[:id])
  if @basket_item.update(basket_item_params)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("basket-item-#{@basket_item.id}", partial: "basket_items/item", locals: { item: @basket_item }) }
      format.html { redirect_to basket_path, notice: "Quantity updated." }
    end
  else
    # handle error
  end
end

  def destroy
    @basket = @basket_item.basket
    @basket_item.destroy
    @total_price = @basket.basket_items.sum do |item|
      product_price(item)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to basket_path(@basket), notice: "Item removed" }
    end
  end

  private

  def set_pharmacy
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
  end

  def set_basket_item
    @basket_item = BasketItem.find(params[:id])
  end

  def basket_item_params
    params.require(:basket_item).permit(:quantity)
  end

  def product_price(item)
    @pharmacy_product = PharmacyProduct.find_by(pharmacy: @pharmacy, product: item.product)
    @pharmacy_product.price * item.quantity
  end
end
