class PharmacyProductsController < ApplicationController
  before_action :authorize_regular_user!

  def authorize_regular_user!
    redirect_to pharmacist_dashboard_path if current_user&.pharmacist?
  end

def create
  @pharmacy = Pharmacy.find(params[:pharmacy_id])
  @product = Product.find(params[:product_id])
  @pharmacy_product = @pharmacy.pharmacy_products.new(product: @product)

  if @pharmacy_product.save
    redirect_to pharmacy_path(@pharmacy), notice: 'Product added to pharmacy successfully.'
  else
    redirect_to pharmacy_path(@pharmacy), alert: 'Failed to add product to pharmacy.'
  end
end

  def update
    @pharmacy_product = PharmacyProduct.find(params[:id])
    if @pharmacy_product.update(pharmacy_product_params)
      redirect_to pharmacy_path(@pharmacy_product.pharmacy), notice: 'Pharmacy product updated successfully.'
    else
      redirect_to pharmacy_path(@pharmacy_product.pharmacy), alert: 'Failed to update pharmacy product.'
    end
  end

def destroy
  @pharmacy_product = PharmacyProduct.find(params[:id])
  @pharmacy = @pharmacy_product.pharmacy
  if @pharmacy_product.destroy
    redirect_to pharmacy_path(@pharmacy), notice: 'Product removed from pharmacy successfully.'
  else
    redirect_to pharmacy_path(@pharmacy), alert: 'Failed to remove product from pharmacy.'
  end

  private
  def pharmacy_product_params
    params.require(:pharmacy_product).permit(:product_id, :price, :stock)
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
  before_action :authenticate_user!, only: [:create, :update, :destroy]
end

end
