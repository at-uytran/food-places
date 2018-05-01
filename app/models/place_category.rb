class PlaceCategory < ApplicationRecord
  has_many :places, dependent: :destroy
  belongs_to :parent, class_name: PlaceCategory.name, optional: true

  scope :order_name, ->{order name: :desc}
end
