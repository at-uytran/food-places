class User < ApplicationRecord
  acts_as_paranoid
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PWD_MIN_LEN = Settings.models.user.password.min_len
  NAME_MAX_LEN = Settings.models.user.name.max_len
  EMAIL_MAX_LEN = Settings.models.user.email.max_len

  attr_accessor :remember_token, :activation_token, :reset_token

  has_secure_password
  has_many :user_ratings, dependent: :destroy
  has_many :subscribe_places, dependent: :destroy
  has_many :user_collections, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_notifications, dependent: :destroy
  has_many :notifications, through: :user_notifications
  has_many :places, dependent: :destroy
  has_one :user_settings, dependent: :destroy
  belongs_to :district

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_save :geocode, if: :address_changed?

  validates :email, presence: {message: I18n.t("activerecord.errors.blank")}, length: {maximum: EMAIL_MAX_LEN},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: {message: I18n.t("activerecord.errors.blank")}, length: {minimum: PWD_MIN_LEN}, allow_nil: true
  validates :name, presence: {message: I18n.t("activerecord.errors.blank")}, length: {maximum: NAME_MAX_LEN}

  enum user_type: {user: 0, place_owner: 1, admin: 2}
  enum status: {active: 0, blocked: 1}
  mount_uploader :avatar, UserImageUploader

  scope :order_by_name, ->{order name: :desc}

  def update_auth_token
    self.auth_token = SecureRandom.urlsafe_base64
    update_attributes auth_digest: digest(auth_token)
  end

  def remove_auth_token
    update_attributes auth_digest: nil
  end

  def digest string
    BCrypt::Password.create string, cost: 10
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def remember
    self.remember_token = User.new_token
    update_attributes(remember_digest: User.digest(remember_token))
  end

  def forget
    update_attributes(remember_digest: nil)
  end

  # class method
  class << self
    def digest string
      cost = BCrypt::Engine.cost
      cost = BCrypt::Engine::MIN_COST if ActiveModel::SecurePassword.min_cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
