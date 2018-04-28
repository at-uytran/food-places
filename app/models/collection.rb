class Collection < ApplicationRecord
  has_many :Collection_palces, dependent: :destroy
end
