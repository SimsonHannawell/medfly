class PharmacyProduct < ApplicationRecord
  belongs_to :pharmacy
  belongs_to :product
end
