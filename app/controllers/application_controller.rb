class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user_basket

  private

def current_user_basket
  return nil unless current_user

  order = Order.where(user_id: current_user.id, delivered?: false).order(created_at: :desc).first
  order&.basket
end

  protected

  def configure_permitted_parameters
    # For sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:pharmacist?, :name, :address])
    # For account update (optional)
    devise_parameter_sanitizer.permit(:account_update, keys: [:pharmacist?, :name, :address])
  end
end
