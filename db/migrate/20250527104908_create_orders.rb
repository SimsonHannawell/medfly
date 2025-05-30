class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :delivered?, default: false
      t.references :basket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
