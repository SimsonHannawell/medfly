class Pharmacy < ApplicationRecord
  has_many_attached :images, dependent: :destroy
  has_many :pharmacy_products, dependent: :destroy
  has_many :products, through: :pharmacy_products
  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_many :baskets, dependent: :destroy

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  validates :name, presence: true
  validates :location, presence: true
end
