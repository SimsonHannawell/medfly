class AddUserToPharmacies < ActiveRecord::Migration[7.1]
  def change
    add_reference :pharmacies, :user, null: false, foreign_key: true
  end
end
