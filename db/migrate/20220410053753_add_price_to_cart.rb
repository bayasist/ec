class AddPriceToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :price_with_tax, :decimal, null: false, after: :selling_product_id, precision: 10, scale: 2
    add_column :cart_items, :price_without_tax, :decimal, null: false, after: :selling_product_id, precision: 10, scale: 2
  end
end
