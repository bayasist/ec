class CreatePurchaseProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_products do |t|
      t.references :selling_product, null: false
      t.references :purchase
      t.string :product_name
      t.decimal :price_with_tax, precision: 10, scale: 2, null: false
      t.decimal :price_without_tax, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
