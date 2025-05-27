class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_reference :users, :payment, foreign_key: true
    add_column :users, :pharmacist?, :boolean, default: false
  end
end
