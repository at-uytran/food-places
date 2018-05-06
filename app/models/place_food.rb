class PlaceFood < ApplicationRecord
  acts_as_paranoid
  belongs_to :place
  belongs_to :food
end
