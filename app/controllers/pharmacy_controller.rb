# app/controllers/pharmacy_controller.rb
class PharmacyController < ApplicationController
  def menu
    @medications = Medication.all.order(:name) # Assuming you have a Medication model
  end

  def item
    @medication = Medication.find(params[:id])
  end

  def discount
    # Implement discount logic here
  end

  def search
    # Implement search logic here

  if params[:query].present?
    @medications = Medication.where("name LIKE ?", "%#{params[:query]}%")
  else
    @medications = Medication.all.order(:name)
  end

  end

  def my_profile
    # Implement profile logic here
  end

  def recieved_orders
    # Implement orders logic here
  end

  def warnings
    # Implement warnings logic here
  end
end
