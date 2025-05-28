class AddCoordinatesToPharmacies < ActiveRecord::Migration[7.1]
  def change
    add_column :pharmacies, :latitude, :float
    add_column :pharmacies, :longitude, :float
  end
end
