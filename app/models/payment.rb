class Payment < ApplicationRecord
  validates :card_number, presence: true, length: { is: 16 }, numericality: { only_integer: true }
  validates :expiry_date, presence: true
  validates :CVC, presence: true, length: { is: 3 }, numericality: { only_integer: true }

  belongs_to :user
end
