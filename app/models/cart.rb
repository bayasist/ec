class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :shipping_address, optional: true

  def find_by_product(selling_product)
    cart_items.find { |item| item.selling_product == selling_product }
  end

  def add(selling_product, quantity = 1)
    cart_item = find_by_product(selling_product) || cart_items.build(selling_product: selling_product)
    cart_item.quantity += quantity
    cart_item.price_with_tax = selling_product.price_with_tax * cart_item.quantity
    cart_item.price_without_tax = selling_product.price_without_tax * cart_item.quantity
  end

  def delete(selling_product)
    find_by_product(selling_product)&.delete
  end


  def save!
    ActiveRecord::Base.transaction do
      super
      cart_items.each(&:save!)
    end
  end
end
