class AddPharmacyToOrders < ActiveRecord::Migration[7.1]
  def change
  add_reference :orders, :pharmacy, foreign_key: true
  end
end
