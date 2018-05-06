class PlaceCategory < ApplicationRecord
  acts_as_paranoid
  has_many :places, dependent: :destroy
  belongs_to :parent, class_name: PlaceCategory.name, optional: true

  scope :order_name, ->{order name: :desc}
end
