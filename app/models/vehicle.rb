# frozen_string_literal: true

class Vehicle < ApplicationRecord
  has_many_attached :images
  after_create :schedule_attach_watermark

  def schedule_attach_watermark
    # binding.pry

    ImageJob.perform_later(id)
  end

  def attach_watermark
    return if images.blank?

    new_images = []
    watermark = Magick::Image.read(Rails.root.join('app', 'assets', 'images', 'ruby.png').to_s).first
    watermark.resize_to_fit!(100, 100)
    images.each do |image|
      filename = File.basename(Faker::File.file_name(dir: nil, ext: 'png')).to_s
      tmp_file = Tempfile.new(filename, Rails.root.join('tmp').to_s)
      tmp_file.binmode
      tmp_file.write(image.download)
      tmp_file.rewind
      image_target_path = Rails.root.join('tmp', filename)
      image_target = Magick::Image.read(tmp_file.path).first
      image_target.composite(watermark, Magick::CenterGravity, Magick::CopyCompositeOp).write(image_target_path)
      tmp_file.unlink
      new_images << image_target_path
      image.purge
    end
    new_images.each do |new_image|
      images.attach(io: File.open(new_image), filename: File.basename(new_image))
    end
  end
end
