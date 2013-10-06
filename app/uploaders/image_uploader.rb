require 'carrierwave/processing/mime_types'

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  #include Sprockets::Helpers::RailsHelper
  #include Sprockets::Helpers::IsolatedHelper
  include CarrierWave::MimeTypes

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :set_content_type
  process :fix_exif_rotation_and_strip

  version :thumb do
    process resize_to_fill: [650, 260]
  end

  version :big do
    process resize_to_limit: [650, nil]
  end

end
