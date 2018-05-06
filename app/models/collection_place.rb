class CollectionPlace < ApplicationRecord
  acts_as_paranoid
  belongs_to :collection
  belongs_to :place
end
