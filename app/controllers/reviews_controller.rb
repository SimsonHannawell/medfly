class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
  end

  def create
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
    @review = @pharmacy.reviews.new(review_params)
    @review.user = current_user # assuming Devise or a custom login system
    @pharmacies = Pharmacy.all

    respond_to do |format|
      if @review.save
        format.html do
          redirect_to pharmacies_path, notice: "Review submitted successfully."
        end
        format.js # renders create.js.erb
      else
        format.html do
          render "pharmacies/index", alert: "Something went wrong."
        end
        format.js # optionally render an error JS file if needed
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
