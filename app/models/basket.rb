class Basket < ApplicationRecord
  belongs_to :pharmacy
  has_one :order
  has_one :user, through: :order

  has_many :basket_items, dependent: :destroy
  has_many :products, through: :basket_items


end
