class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @payment = current_user.payment || Payment.new
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path, notice: "Account updated successfully."
    else
      flash.now[:alert] = "Failed to update account."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address)
  end
end
