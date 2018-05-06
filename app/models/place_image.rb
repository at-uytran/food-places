class PlaceImage < ApplicationRecord
  acts_as_paranoid
  belongs_to :place
  belongs_to :comment, optional: true
end
