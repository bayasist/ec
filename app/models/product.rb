class Product < ApplicationRecord
  has_many :stocks

  def allowable_quantity_by_warehouse(warehouse)
    stocks.find { |stock| stock.warehouse == warehouse }.allowable_quantity
  end
end
