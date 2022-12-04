class ImageJob < ApplicationJob
  queue_as :default

  def perform(vehicle_id)
    Vehicle.find(vehicle_id).attach_watermark
  end
end
