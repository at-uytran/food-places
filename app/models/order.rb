class Order < ApplicationRecord
  acts_as_paranoid
  has_many :carts, dependent: :destroy
  belongs_to :user
  belongs_to :place
  enum status: {draft: 0, pending: 1, processing: 2, shiping: 3, received: 4}
  enum payment_status: {not_paid: 0, paid: 1}

  def total_quantity
    return 0 unless carts
    carts.pluck(:quantity).inject(:+)
  end

  def total_price
    return 0 unless carts
    price = 0
    carts.each do |cart|
      price += cart.food.price
    end
    price
  end
end
