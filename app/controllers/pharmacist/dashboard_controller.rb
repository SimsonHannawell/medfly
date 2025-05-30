class Pharmacist::DashboardController < Pharmacist::BaseController
  before_action :authenticate_user!
  before_action :ensure_pharmacist

  def index
    @pharmacies = current_user.pharmacies.includes(pharmacy_products: :product)
  end

  private

  def ensure_pharmacist
    redirect_to root_path, alert: "Access denied" unless current_user.pharmacist?
  end
end
