class PharmaciesController < ApplicationController
  # app/controllers/pharmacies_controller.rb

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
    @products = @pharmacy.products.includes(:product_images)
  end

  private

  def current_user
    # Assuming you have a method to get the current user, e.g., from Devise
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: 'You need to sign in or sign up before continuing.'
    end
  end

  before_action :authenticate_user!, only: [:index, :show]

  def pharmacy_params
    params.require(:pharmacy).permit(:name, :address, :phone_number, :email)
  end
end
