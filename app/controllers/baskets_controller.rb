class BasketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_basket_item, only: [:update, :destroy]

def show
  @basket = Basket.find(params[:id])
  @pharmacy = @basket.pharmacy
  @basket_items = @basket.basket_items

   @total_price = @basket.basket_items.sum do |item|
      product_price(item)
    end

end


def update
    if @basket_item.update(basket_item_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("basket-item-#{@basket_item.id}", partial: "basket_items/item", locals: { item: @basket_item }) }
        format.html { redirect_to basket_path(current_user_active_basket), notice: "Quantity updated." }
      end
    else
      redirect_to basket_path(current_user_active_basket), alert: "Failed to update item."
    end
  end

  def destroy
    @basket_item.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("basket-item-#{@basket_item.id}") }
      format.html { redirect_to basket_path(current_user_active_basket), notice: "Item removed." }
    end
  end

  private

  def set_basket_item
    @basket_item = BasketItem.find(params[:id])
  end

  def basket_item_params
    params.require(:basket_item).permit(:quantity)
  end

  def current_user_active_basket
    order = current_user.orders.find_by(delivered?: false)
    order&.basket
  end

   def product_price(item)

    @pharmacy_product = PharmacyProduct.find_by(pharmacy: @pharmacy, product: item.product)
    @pharmacy_product.price * item.quantity
  end
end
