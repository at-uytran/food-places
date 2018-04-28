class Order < ApplicationRecord
  has_many :carts, dependent: :destroy
  belongs_to :user
  belongs_to :place
  enum status: {pending: 0, processing: 1, shiping: 2}
end
