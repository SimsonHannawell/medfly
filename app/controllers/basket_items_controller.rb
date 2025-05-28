class BasketItemsController < ApplicationController
  def create
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
    @basket_item = @pharmacy.basket_items.new(basket_item_params)
    @basket_item.user = current_user

    if @basket_item.save
      redirect_to pharmacy_path(@pharmacy), notice: 'Item added to basket.'
    else
      redirect_to pharmacy_path(@pharmacy), alert: 'Failed to add item to basket.'
    end
  end

  def update
    @basket_item = BasketItem.find(params[:id])
    if @basket_item.update(basket_item_params)
      redirect_to pharmacy_path(@basket_item.pharmacy), notice: 'Basket item updated successfully.'
    else
      redirect_to pharmacy_path(@basket_item.pharmacy), alert: 'Failed to update basket item.'
    end
  end

  def destroy
    @basket_item = BasketItem.find(params[:id])
    @pharmacy = @basket_item.pharmacy
    if @basket_item.destroy
      redirect_to pharmacy_path(@pharmacy), notice: 'Item removed from basket.'
    else
      redirect_to pharmacy_path(@pharmacy), alert: 'Failed to remove item from basket.'
    end
  end

  private

  def basket_item_params
    params.require(:basket_item).permit(:product_id, :quantity)
  end

end
