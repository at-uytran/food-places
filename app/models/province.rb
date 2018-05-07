class Province < ApplicationRecord
  acts_as_paranoid
  has_many :districts, dependent: :destroy
end
