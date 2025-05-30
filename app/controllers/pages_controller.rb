class PagesController < ApplicationController
  def home
    if current_user && current_user.pharmacist?
      redirect_to pharmacist_root_path
    end
  end
end
