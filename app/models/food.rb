class Food < ApplicationRecord
  acts_as_paranoid
  has_many :place_foods, dependent: :destroy
  belongs_to :food_category
  belongs_to :food_category
  has_many :carts, dependent: :nullify
  enum food_type: {food: 0, drink: 1}

  delegate :name, to: :food_category, prefix: true
end
