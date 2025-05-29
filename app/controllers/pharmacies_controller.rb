class PharmaciesController < ApplicationController
  before_action :authorize_regular_user!

  def authorize_regular_user!
    redirect_to pharmacist_dashboard_path if current_user&.pharmacist?
  end

    def index
    if params[:search].present?
      puts "Search params: #{params[:search]}"  # <-- Add here for debugging input

      # Geocode the city to get coordinates
      city_coords = Geocoder.search(params[:search]).first&.coordinates

      puts "Geocoded coordinates: #{city_coords.inspect}" if city_coords  # <-- Add here for geocode output

      if city_coords
        # Find pharmacies within 1 mile of the city coordinates
        @pharmacies = Pharmacy.near(city_coords, 20).to_a
      else
        # If geocoding fails, fallback to text-based search
        @pharmacies = Pharmacy.where("location ILIKE ?", "%#{params[:search]}%").to_a
      end
    else
      @pharmacies = Pharmacy.all
    end
  end

  def show
    # no changes here
    @pharmacy = Pharmacy.find(params[:id])
    @products = @pharmacy.products
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def pharmacy_params
    params.require(:pharmacy).permit(:name, :address, :phone_number, :email)
  end
end
