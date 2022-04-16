class StockRecord < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product
  belongs_to :purchase_product, optional: true
end
