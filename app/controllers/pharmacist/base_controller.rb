class Pharmacist::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_pharmacist!

  private

  def authorize_pharmacist!
    unless current_user&.pharmacist?
      redirect_to root_path, alert: "Access denied: Pharmacists only."
    end
  end
end

