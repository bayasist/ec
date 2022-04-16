class Purchase < ApplicationRecord
  has_one :purchase_payment
  has_one :purchase_shipping_address
  has_many :purchase_products

  def self.initialize_by_cart(cart)
    result = Purchase.new(sold_at: Time.zone.now, code: generate_order_code, member_id: cart.member_id)
    result.price_with_tax = cart.price_with_tax
    result.price_without_tax = cart.price_without_tax
    result.purchase_payment = PurchasePayment.new(total_price: cart.price_with_tax, payment_method: cart.payment_method || cart.member.default_payment_method)
    shipping_address = cart.shipping_address || cart.member.default_shipping_address
    result.purchase_shipping_address = PurchaseShippingAddress.new(
      shipping_address_id: shipping_address.id,
      name: shipping_address.name,
      prefecture: shipping_address.prefecture,
      city: shipping_address.city,
      address_line: shipping_address.address_line,
      building_name: shipping_address.building_name
    )
    cart.cart_items.each do |item|
      result.purchase_products.build(
        selling_product_id: item.selling_product_id,
        product_name: item.selling_product.name,
        price_with_tax: item.price_with_tax,
        price_without_tax: item.price_without_tax
      )
    end
    result
  end

  def self.generate_order_code
    rand(1000000...10000000).to_s
  end

  def reserve_stock!
    purchase_products.each(&:reserve_stock!)
  end

  def payment!
    purchase_payment.payment!
  end
end
