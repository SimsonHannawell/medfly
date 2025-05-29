class PharmaciesController < ApplicationController

  # app/controllers/pharmacies_controller.rb

  before_action :authorize_regular_user!

  def authorize_regular_user!
    redirect_to pharmacist_dashboard_path if current_user&.pharmacist?
  end

  def index
    if params[:search].present?
      # Simple case-insensitive search for pharmacies whose location includes the search string
      @pharmacies = Pharmacy.where("location ILIKE ?", "%#{params[:search]}%")
    else
      @pharmacies = Pharmacy.all
    end
  end


  def show
     @pharmacy = Pharmacy.find(params[:id])
  end

  private

  def current_user
    # Assuming you have a method to get the current user, e.g., from Devise
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



  def pharmacy_params
    params.require(:pharmacy).permit(:name, :address, :phone_number, :email)
  end
end
