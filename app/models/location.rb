class Location < ApplicationRecord
  acts_as_paranoid
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :district, optional: true
  belongs_to :place
end
