class AddUserIdToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :user_id, :integer
    add_index :payments, :user_id
  end
end
