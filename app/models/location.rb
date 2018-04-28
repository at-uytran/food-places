class Location < ApplicationRecord
  belongs_to :district, optional: true
  belongs_to :place
end
