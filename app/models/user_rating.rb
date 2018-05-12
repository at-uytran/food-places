class UserRating < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :place
  validates :title, presence: true
  validates :content, presence: true

  def average_points
    if score_location || score_serve || score_space || score_price || score_quality
      (score_location.to_i + score_serve.to_i + score_space.to_i + score_price.to_i + score_quality.to_i) / 5
    end
  end
end
