class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item
  enum making_status: {cannot_be_manufactured: 0, wating_for_production: 1, in_production: 2, completion_of_production: 3}
  def with_tax_price
    (price*1.1).floor
  end

  def subtotal
    with_tax_price * amount
  end
end
