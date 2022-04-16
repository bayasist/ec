class Warehouse < ApplicationRecord
  scope :open, -> { where(deleted_at: nil) }
  after_create :craete_stock

  private

  def craete_stock
    Product.all.each do |product|
      stock = Stock.find_or_initialize_by(
        warehouse_id: self.id, product_id: product.id)
      next if stock.persisted?
      stock.attributes = {
        quantity: 0,
        allowable_quantity: 0,
        process_quantity: 0,
        bad_quantity: 0,
        hold_quantity:0
      }
      stock.save!
    end
  end
end
