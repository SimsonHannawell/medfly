class Review < ApplicationRecord
  belongs_to :pharmacy
  belongs_to :user
end
