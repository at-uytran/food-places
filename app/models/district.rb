class District < ApplicationRecord
  acts_as_paranoid
  belongs_to :province
  has_many :locations, dependent: :destroy
  has_many :places, through: :locations
end
