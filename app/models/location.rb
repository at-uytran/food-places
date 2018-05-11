class Location < ApplicationRecord
  acts_as_paranoid
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_save :geocode, if: :address_changed?
  belongs_to :district, optional: true
  belongs_to :place
  scope :created_desc, ->{order created_at: :desc}
  scope :with_approve_place, ->{joins(:place).where("places.status = ?", 1)}
end
