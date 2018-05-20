class District < ApplicationRecord
  # acts_as_paranoid
  belongs_to :province
  has_many :locations, dependent: :destroy
  has_many :user_locations, dependent: :destroy
  has_many :users, dependent: :nullify
  has_many :places, dependent: :nullify
end
