class Review < ApplicationRecord
  belongs_to :pharmacy
  belongs_to :user

  validates :rating, inclusion: { in: 1..5 }, presence: true
  validates :description, presence: true
end
