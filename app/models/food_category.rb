class FoodCategory < ApplicationRecord
  acts_as_paranoid
  has_many :foods, dependent: :destroy
  belongs_to :parent, class_name: FoodCategory.name, optional: true
  has_many :childrens, class_name: FoodCategory.name,
    foreign_key: :parent_id, dependent: :destroy
end
