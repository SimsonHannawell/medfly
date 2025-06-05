class PharmaciesController < ApplicationController
  before_action :authorize_regular_user!

  # Redirect pharmacists to their dashboard
  def authorize_regular_user!
    redirect_to pharmacist_root_path if current_user&.pharmacist?
  end

  def index
    # Step 1: Start with all pharmacies or filter by location
    if params[:search].present?
      # Try to geocode the search term (e.g. a city name)
      city_coords = Geocoder.search(params[:search]).first&.coordinates

      if city_coords
        # Find pharmacies within 50 miles of the geocoded coordinates
        @pharmacies = Pharmacy.near(city_coords, 50)
      else
        # Fallback: use text-based search on location
        @pharmacies = Pharmacy.where("location ILIKE ?", "%#{params[:search]}%")
      end
    else
      @pharmacies = Pharmacy.all
    end

    # Step 2: Filter by associated product name (if any)
    if params[:product].present?
      @pharmacies = @pharmacies.joins(:products).where("products.name ILIKE ?", "%#{params[:product]}%")
    end

    # Step 3: Filter by illness (exact match)
    if params[:illness].present? && params[:illness] != "Any"
      @pharmacies = @pharmacies.joins(:products).where(products: { illness: params[:illness] })
    end

    # Step 4: Filter by product brand
    if params[:brand].present? && params[:brand] != "Any"
      @pharmacies = @pharmacies.joins(:products).where(products: { brand: params[:brand] })
    end

    # Step 5: Filter by pharmacy type (24/7, Hospital, etc.)
    if params[:type].present? && params[:type] != "Any"
      @pharmacies = @pharmacies.where(pharmacy_type: params[:type])
    end

    # Step 6: Filter by product dosage form (array of types)
    if params[:form_types].present?
      @pharmacies = @pharmacies.joins(:products).where(products: { dosage_form: params[:form_types] })
    end

    # Step 7: Filter by minimum product price
    if params[:min_price].present?
      @pharmacies = @pharmacies.joins(:products).where("products.price >= ?", params[:min_price].to_f)
    end

    # Step 8: Filter by maximum product price
    if params[:max_price].present?
      @pharmacies = @pharmacies.joins(:products).where("products.price <= ?", params[:max_price].to_f)
    end

    # Step 9: Filter by whether a prescription is required
    if params[:prescription].present? && params[:prescription] != ""
      prescription_required = params[:prescription] == "yes"
      @pharmacies = @pharmacies.joins(:products).where(products: { prescription_required: prescription_required })
    end

    # Step 10: Filter for pharmacies that are currently open
    if params[:open_now].present?
      @pharmacies = @pharmacies.where(open_now: true)
    end

    # Step 11: Ensure no duplicate pharmacies from multiple product matches
    @pharmacies = @pharmacies.distinct.to_a
  end

  def show
    @pharmacy = Pharmacy.find(params[:id])
    @review = @pharmacy.reviews.new
    @products = @pharmacy.products
    @basket_item = BasketItem.new
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def pharmacy_params
    params.require(:pharmacy).permit(:name, :address, :phone_number, :email)
  end
end
