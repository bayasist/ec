class AddPriceToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :selling_products, :price, :integer, null: false, after: :name
    add_column :selling_products, :price_type, :integer, null: false, after: :price
    add_reference :selling_products, :tax_type, null: false, after: :price
  end
end
