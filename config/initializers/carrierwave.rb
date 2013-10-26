module CarrierWave
  module MiniMagick
    # Reduces the quality of the image
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage)
        img = yield(img) if block_given?
        img
      end
    end

    # Rotates the image based on the EXIF Orientation
    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient
        img = yield(img) if block_given?
        img
      end
    end

    # Strips out all embedded information from the image
    def strip
      manipulate! do |img|
        img = yield(img) if block_given?
        img
      end
    end

    # Combines Exif rotation and Strip
    def fix_exif_rotation_and_strip
      manipulate! do |img|
        img.auto_orient
        img.strip
        img = yield(img) if block_given?
        img
      end
    end

    def resize_to_fit_if_bigger(width, height)
      manipulate! do |img|
        cols, rows = img[:dimensions]
        if cols > width# || rows > height
          img.combine_options do |cmd|
            if width != cols || height != rows
              scale = [width/cols.to_f, height/rows.to_f].max
              cols = (scale * (cols + 0.5)).round
              rows = (scale * (rows + 0.5)).round
              cmd.resize "#{cols}x#{rows}"
            end
            cmd.background 'none'
            cmd.gravity 'Center'
            cmd.extent "#{width}x#{height}" if cols != width || rows != height
          end
        end
        img = yield(img) if block_given?
        img
      end
    end
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
