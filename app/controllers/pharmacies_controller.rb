class PharmaciesController < ApplicationController
  def index
    @pharmacies = Pharmacy.all
  end

  def show
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
