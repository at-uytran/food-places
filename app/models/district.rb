class District < ApplicationRecord
  belongs_to :province
  has_many :locations, dependent: :destroy
  has_many :places, through: :locations
end
