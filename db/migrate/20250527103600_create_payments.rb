class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :card_number
      t.integer :expiry_date
      t.integer :CVC

      t.timestamps
    end
  end
end
