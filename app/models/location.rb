class Location < ApplicationRecord
  acts_as_paranoid
  belongs_to :district, optional: true
  belongs_to :place
end
