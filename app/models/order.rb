class Order < ApplicationRecord
  acts_as_paranoid
  has_many :carts, dependent: :destroy
  belongs_to :user
  belongs_to :place
  enum status: {pending: 0, processing: 1, shiping: 2}
  enum pay_status: {not_paid: 0, paid: 1}
end
