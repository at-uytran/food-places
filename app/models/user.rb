class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :auth_token, :confirm_token, :reset_token

  has_secure_password
  has_many :user_ratings, dependent: :destroy
  has_many :subscribe_places, dependent: :destroy
  has_many :user_collections, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_notifications, dependent: :destroy
  has_one :user_settings, dependent: :destroy
  has_many :notifications, through: :user_notifications
  has_many :places, dependent: :destroy

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
end
