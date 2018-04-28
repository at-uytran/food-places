class PlaceFood < ApplicationRecord
  belongs_to :place
  belongs_to :food
end
