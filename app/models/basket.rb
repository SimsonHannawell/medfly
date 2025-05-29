class Basket < ApplicationRecord
  belongs_to :pharmacy
  has_one :order, dependent: :destroy
  has_one :user, through: :order

  has_many :basket_items, dependent: :destroy
  has_many :products, through: :basket_items
  has_one_attached :photo
end
