class Notification < ApplicationRecord
  acts_as_paranoid
  has_many :user_notifications, dependent: :destroy
end
