class Basket < ApplicationRecord
  belongs_to :pharmacy
  has_many :basket_items, dependent: :destroy
  has_many :products, through: :basket_items
end

