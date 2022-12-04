# frozen_string_literal: true

require 'rmagick'
class Vehicle < ApplicationRecord
  has_many_attached :images
  # after_create :attach_watermark

  def attach_watermark
    return if images.blank?

    # watermark = Rails.root.join('app', 'assets', 'images', 'ruby.png')
    # images.each do |image|
    #   tmp_file = Tempfile.new(File.basename(Faker::File.file_name(ext: 'png')))
    #   tmp_file.binmode
    #   tmp_file.write(image.download)
    #   tmp_file.rewind
    #   image_list = Magick::ImageList.new(tmp_file.path, watermark.to_s)
    #   image_list.write(Rails.root.join('app', 'assets', 'images',
    #                                    File.basename(Faker::File.file_name(dir: nil, ext: 'png'))).to_s)
    # end

    watermark = Magick::Image.read(Rails.root.join('app', 'assets', 'images', 'ruby.png').to_s).first
    images.each do |image|
      tmp_file = Tempfile.new
      tmp_file.binmode
      tmp_file.write(image.download)
      tmp_file.rewind
      image_path = Magick::Image.read(tmp_file.path).first
      image_path.composite(watermark, Magick::NorthWestGravity, 0, 0, Magick::OverCompositeOp)
      image_path.watermark(watermark)
      image_path.write(Rails.root.join('app', 'assets', 'images',
                                       File.basename(Faker::File.file_name(dir: nil, ext: 'png'))).to_s)
    end
  end
end
