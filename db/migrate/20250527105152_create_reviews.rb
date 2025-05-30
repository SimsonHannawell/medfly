class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :pharmacy, null: false, foreign_key: true
      t.integer :rating
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
