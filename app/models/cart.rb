class Cart < ApplicationRecord
  has_many :cart_items

  def find_by_product(selling_product)
    cart_items.find { |item| item.selling_product == selling_product }
  end

  def add(selling_product, quantity = 1)
    cart_item = find_by_product(selling_product) || cart_items.build(selling_product: selling_product)
    cart_item.quantity += quantity
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
