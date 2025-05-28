class Order < ApplicationRecord
  belongs_to :user
  belongs_to :basket

  after_create :schedule_delivery_mark

  private

  def schedule_delivery_mark
    MarkOrderDeliveredJob.set(wait: 10.seconds).perform_later(self.id)
  end
end

