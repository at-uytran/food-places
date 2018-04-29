class Place < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_collections, dependent: :destroy
  has_many :subscribe_places, dependent: :destroy
  has_many :user_ratings, dependent: :destroy
  has_many :place_foods, dependent: :destroy
  has_many :collection_places, dependent: :destroy
  has_many :place_images, dependent: :destroy
  has_one :location, dependent: :destroy
  belongs_to :place_category
  has_many :foods, through: :place_foods
  has_many :collections, through: :collection_places
  belongs_to :owner, class_name: User.name

  enum status: {pending: 0, approved: 1}
  delegate :name, :email, to: :owner, prefix: true

  scope :created_desc, ->{order name: :desc}

  def rate_point
    return I18n.t("places.rating_average.n_a") if user_ratings.blank?
    user_ratings.each do |rating|
      @points += rating.point
    end
    @points / user_ratings.size
  end

  def total_images
    place_images.size
  end

  def total_reviews
    user_ratings.size
  end
end
