class Pharmacist::PharmaciesController < Pharmacist::BaseController
  before_action :set_pharmacy, only: [:edit, :update, :destroy]

  def new
    @pharmacy = Pharmacy.new
  end

  def create
    @pharmacy = Pharmacy.new(pharmacy_params)
    if @pharmacy.save
      redirect_to pharmacist_root_path, notice: "Pharmacy created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pharmacy.update(pharmacy_params)
      redirect_to pharmacist_root_path, notice: "Pharmacy updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @pharmacy.destroy
    redirect_to pharmacist_root_path, notice: "Pharmacy deleted successfully."
  end

  private

  def set_pharmacy
    @pharmacy = Pharmacy.find(params[:id])
  end

  def pharmacy_params
    params.require(:pharmacy).permit(:name, :address, :phone_number) # add your fields here
  end
end
