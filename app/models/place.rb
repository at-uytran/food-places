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
  has_one :location, dependent: :destroy
  has_one :place_setting, dependent: :destroy
  belongs_to :place_category
  has_many :foods, through: :place_foods
  has_many :collections, through: :collection_places
  belongs_to :owner, class_name: User.name, optional: true
  mount_uploader :image, PlaceImageUploader

  validates :address, presence: {message: I18n.t("activerecord.errors.blank")}
  validates :name, presence: {message: I18n.t("activerecord.errors.blank")}

  enum status: {pending: 0, approved: 1, blocked: 2}
  delegate :name, :email, to: :owner, prefix: true

  scope :created_desc, ->{order name: :desc}
  scope :by_categories, ->(ids){where(place_category_id: ids) if ids.present?}
  scope :allow_order, ->{joins(:place_setting).where place_settings: {allow_order: true}}

  def rate_point_average
    return I18n.t("places.rating_average.n_a") if user_ratings.blank?
    points = 0
    user_ratings.each do |rating|
      points += rating.points
    end
    points / user_ratings.size
  end

  def total_images
    place_images.size
  end

  def total_reviews
    user_ratings.size
  end

  private

  def create_setting
    create_place_setting! allow_order: false, enable: true
  end
end
