class UserRating < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :place
  has_many :user_rating_images, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :user_rating_images

  def average_points
    return unless score_location || score_serve || score_space || score_price || score_quality
    (score_location.to_i + score_serve.to_i + score_space.to_i + score_price.to_i + score_quality.to_i) / 5.0
  end
end
