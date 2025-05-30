class BasketItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pharmacy

  def create
    order = current_user.orders.find_or_create_by!(pharmacy: @pharmacy, delivered?: false)
    basket = order.basket || order.create_basket(pharmacy: @pharmacy)

    basket_item = basket.basket_items.find_or_initialize_by(product_id: params[:product_id])
    basket_item.quantity += params[:quantity].to_i
    basket_item.save!

    # Recalculate total using pharmacy_products pricing
    total_price = basket.basket_items.joins("INNER JOIN pharmacy_products ON pharmacy_products.product_id = basket_items.product_id AND pharmacy_products.pharmacy_id = #{basket.pharmacy_id}")
                                     .sum("pharmacy_products.price * basket_items.quantity")

    render json: {
      success: true,
      total_price: total_price,
      basket_id: basket.id
    }
  rescue => e
    Rails.logger.error("BasketItems#create error: #{e.message}")
    render json: { error: e.message }, status: :unprocessable_entity
  end


  def update
    basket_item = BasketItem.find(params[:id])
    if basket_item.update(basket_item_params)
      redirect_to pharmacy_path(basket_item.basket.pharmacy), notice: 'Basket item updated successfully.'
    else
      redirect_to pharmacy_path(basket_item.basket.pharmacy), alert: 'Failed to update basket item.'
    end
  end

  def destroy
    basket_item = BasketItem.find(params[:id])
    pharmacy = basket_item.basket.pharmacy
    if basket_item.destroy
      redirect_to pharmacy_path(pharmacy), notice: 'Item removed from basket.'
    else
      redirect_to pharmacy_path(pharmacy), alert: 'Failed to remove item from basket.'
    end
  end

  private

  def basket_item_params
    params.require(:basket_item).permit(:product_id, :quantity)
  end

  def set_pharmacy
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
  end

end
