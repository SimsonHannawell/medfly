class ReviewsController < ApplicationController
  def new
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
    @review = @pharmacy.reviews.new
  end

  def create
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
    @review = @pharmacy.reviews.new(review_params)
    @review.user = current_user # assuming Devise or custom login system

    if @review.save
      redirect_to pharmacy_path(@pharmacy), notice: "Review submitted successfully."
    else
      render :new, alert: "Something went wrong."
    end
  end # ✅ This was missing

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
# This controller handles the creation of reviews for pharmacies.
