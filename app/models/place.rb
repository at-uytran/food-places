class Place < ApplicationRecord
  acts_as_paranoid

  after_create :create_setting

  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_collections, dependent: :destroy
  has_many :subscribe_places, dependent: :destroy
  has_many :user_ratings, dependent: :destroy
  has_many :place_foods, dependent: :destroy
  has_many :collection_places, dependent: :destroy
  has_many :place_images, dependent: :destroy
  has_many :foods, through: :place_foods
  has_many :collections, through: :collection_places
  has_one :place_setting, dependent: :destroy
  belongs_to :place_category
  belongs_to :district
  belongs_to :owner, class_name: User.name, optional: true

  geocoded_by :address
  # after_validation :geocode, if: :address_changed?
  after_save :geocode, if: :address_changed?

  mount_uploader :image, PlaceImageUploader

  validates :address, presence: {message: I18n.t("activerecord.errors.blank")}
  validates :name, presence: {message: I18n.t("activerecord.errors.blank")}

  enum status: {pending: 0, approved: 1, discard: 2, blocked: 3}
  delegate :name, :email, to: :owner, prefix: true

  scope :created_desc, ->{order created_at: :desc}
  scope :by_categories, ->(ids){where(place_category_id: ids) if ids.present?}
  scope :allow_order, ->{joins(:place_setting).where place_settings: {allow_order: true}}
  scope :orders_desc, ->{joins(:orders).select("places.*, COUNT(orders.id) as order_count").group("orders.id")}

  def success_orders_size
    # orders.where()
  end

  def rate_point_average
    return I18n.t("places.rating_average.n_a") if user_ratings.blank?
    points = 0
    user_ratings.each do |rating|
      points += rating.average_points.to_f
    end
    (points / user_ratings.size).round(2)
  end

  def quality_point
    return I18n.t("n_a") if user_ratings.blank?
    points = 0
    user_ratings.each do |rating|
      points += rating.score_quality.to_f
    end
    (points / user_ratings.size).round(2)
  end

  def location_point
    return I18n.t("n_a") if user_ratings.blank?
    points = 0
    user_ratings.each do |rating|
      points += rating.score_location.to_f
    end
    (points / user_ratings.size).round(2)
  end

  def space_point
    return I18n.t("n_a") if user_ratings.blank?
    points = 0
    user_ratings.each do |rating|
      points += rating.score_space.to_f
    end
    (points / user_ratings.size).round(2)
  end

  def serve_point
    return I18n.t("n_a") if user_ratings.blank?
    points = 0
    user_ratings.each do |rating|
      points += rating.score_serve.to_f
    end
    (points / user_ratings.size).round(2)
  end

  def price_point
    return I18n.t("n_a") if user_ratings.blank?
    points = 0
    user_ratings.each do |rating|
      points += rating.score_price.to_f
    end
    (points / user_ratings.size).round(2)
  end

  def allow_order?
    place_setting.allow_order
  end

  def total_images
    size = 0
    user_ratings.each do |user_rating|
      size += user_rating.images_size
    end
    place_images.size + size
  end

  def total_reviews
    user_ratings.size
  end

  private

  def create_setting
    create_place_setting! allow_order: false, enable: true
  end
end
