class UserRatingImage < ApplicationRecord
  belongs_to :user_rating
  mount_uploader :image, UserRatingImageUploader
end
