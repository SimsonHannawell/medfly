class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_reference :users, :payment, null: false, foreign_key: true
    add_column :users, :pharmacy, :boolean
  end
end
