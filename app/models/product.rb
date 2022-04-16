class Product < ApplicationRecord
  has_many :stocks
  after_create :craete_stock

  def allowable_quantity_by_warehouse(warehouse)
    stock_by_warehouse(warehouse).allowable_quantity
  end

  def stock_by_warehouse(warehouse)
    stocks.find { |stock| stock.warehouse == warehouse }
  end

  private

  def craete_stock
    Warehouse.all.each do |warehouse|
      stock = Stock.find_or_initialize_by(
        warehouse_id: warehouse.id, product_id: self.id)
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
