class CreateMedications < ActiveRecord::Migration[7.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.text :images

      t.timestamps
    end
  end
end
