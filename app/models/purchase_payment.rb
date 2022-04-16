class PurchasePayment < ApplicationRecord
  belongs_to :payment_method

  def payment!
    result = payment_method.payment!(total_price)
    update!(stripe_payment_id: result["id"])
  end
end
