class UserImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_and_pad: [Settings.models.user.image.width, Settings.models.user.image.height]
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url *_args
    "/images/fallback/" + [version_name, "user-image-default.jpg"].compact.join("_")
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
