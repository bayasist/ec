class PaymentMethod < ApplicationRecord
  belongs_to :member
  before_create :add_index
  
  def retrieve_stripe
    Stripe::PaymentMethod.retrieve(
      stripe_paymen_method_id,
    )
  end

  def mask_card_no
    (1..12).map { |_| "*" }.join + retrieve_stripe["card"]["last4"]
  end

  def payment!(price)
    Stripe::PaymentIntent.create({
      amount: price,
      currency: 'jpy',
      payment_method_types: ['card'],
      payment_method: stripe_paymen_method_id,
      customer: member.stripe_customer_id
    })
  end

  private

  def add_index
    return if index.present?
    self.index = (self.class.where(member_id: member.id).pluck(:index).max || 0) + 1
  end
end
