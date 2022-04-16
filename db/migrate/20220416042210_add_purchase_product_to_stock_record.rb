class AddPurchaseProductToStockRecord < ActiveRecord::Migration[7.0]
  def change
    add_reference :stock_records, :purchase_product, null: true
  end
end
