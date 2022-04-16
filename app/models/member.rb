class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart
  has_many :shipping_addresses
  belongs_to :default_shipping_address, class_name: "ShippingAddress", optional: true
  belongs_to :default_payment_method, class_name: "PaymentMethod", optional: true
  has_many :payment_methods

  def create_stripe_customer
    return if created_stripe_customer?
    result = Stripe::Customer.create({
      metadata: {
        member_id: self.id
      }
    })
    self.update(stripe_customer_id: result.id)
  end

  def created_stripe_customer?
    stripe_customer_id.present?
  end

  def create_stripe_payment_method(stripe_paymen_method_id)
    Stripe::PaymentMethod.attach(
      stripe_paymen_method_id,
      {
        customer: stripe_customer_id,
      }
    )
    payment_methods.create!(stripe_paymen_method_id: stripe_paymen_method_id)
  end
end
