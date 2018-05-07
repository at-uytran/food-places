class Collection < ApplicationRecord
  acts_as_paranoid
  has_many :Collection_palces, dependent: :destroy
end
