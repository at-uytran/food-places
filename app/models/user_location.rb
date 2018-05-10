class UserLocation < ApplicationRecord
  acts_as_paranoid
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_save :geocode, if: :address_changed?
  belongs_to :district, optional: true
  belongs_to :user
end
