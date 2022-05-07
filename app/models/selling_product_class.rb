class SellingProductClass < ApplicationRecord
  has_many :selling_products
  accepts_nested_attributes_for :selling_products, allow_destroy: true

  def price_with_tax_range
    return nil if selling_products.blank?
    (selling_products.map(&:price_with_tax).min)..(selling_products.map(&:price_with_tax).max)
  end
end
