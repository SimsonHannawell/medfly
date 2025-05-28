class UsersController < ApplicationController
  before_action :authenticate_user!

  # Show the current user's account page
  def account
    @user = current_user
  end

  # Edit form for current user
  def edit
    @user = current_user
    @payment = current_user.payment || Payment.new
  end

  # Update user info
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_account_path, notice: "Account updated successfully."
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
