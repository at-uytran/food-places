class PlaceImage < ApplicationRecord
  belongs_to :place
  belongs_to :comment, optional: true
end
