class Product < ApplicationRecord
  has_many_attached :photo
  has_many :pharmacy_products
  has_many :pharmacies, through: :pharmacy_products

  validates :name, presence: true
  validates :description, presence: true
end
