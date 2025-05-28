class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # For sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:pharmacist?, :name, :address])
    # For account update (optional)
    devise_parameter_sanitizer.permit(:account_update, keys: [:pharmacist?, :name, :address])
  end
end
