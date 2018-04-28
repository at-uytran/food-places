class Food < ApplicationRecord
  has_many :place_foods, dependent: :destroy
  belongs_to :food_category
  belongs_to :food_category
  has_many :carts, dependent: :nullify
  enum food_type: {food: 0, drink: 1}
end
