class Pharmacist::PharmacyProductsController < Pharmacist::BaseController
  before_action :set_pharmacy

  def create
    @product = @pharmacy.pharmacy_products.build(pharmacy_product_params)
    if @product.save
      redirect_to edit_pharmacist_pharmacy_path(@pharmacy), notice: "Product added."
    else
      redirect_to edit_pharmacist_pharmacy_path(@pharmacy), alert: "Failed to add product."
    end
  end

  def update
    @product = @pharmacy.pharmacy_products.find(params[:id])
    if @product.update(pharmacy_product_params)
      redirect_to edit_pharmacist_pharmacy_path(@pharmacy), notice: "Product updated."
    else
      redirect_to edit_pharmacist_pharmacy_path(@pharmacy), alert: "Failed to update product."
    end
  end

  def destroy
    @product = @pharmacy.pharmacy_products.find(params[:id])
    @product.destroy
    redirect_to edit_pharmacist_pharmacy_path(@pharmacy), notice: "Product removed."
  end

  private

  def set_pharmacy
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
  end

  def pharmacy_product_params
    params.require(:pharmacy_product).permit(:name, :description, :price, :stock) # adjust per your model
  end
end
