class Cart < ApplicationRecord
  acts_as_paranoid
  belongs_to :order
  belongs_to :food, optional: true
end
