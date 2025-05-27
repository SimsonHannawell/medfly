class Pharmacy < ApplicationRecord
  has_many :pharmacy_products
  has_many :products, through: :pharmacy_products
  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :location, presence: true
end
