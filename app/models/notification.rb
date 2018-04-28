class Notification < ApplicationRecord
  has_many :user_notifications, dependent: :destroy
end
