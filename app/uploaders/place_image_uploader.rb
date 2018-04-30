class PlaceImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_and_pad: [Settings.models.place.image.width, Settings.models.place.image.height]
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url *_args
    "/images/fallback/" + [version_name, "place-image-default.jpg"].compact.join("_")
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
