# app/jobs/mark_order_delivered_job.rb
class MarkOrderDeliveredJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find_by(id: order_id)
    return unless order && !order.delivered?

    order.update(delivered?: true)
  end
end
