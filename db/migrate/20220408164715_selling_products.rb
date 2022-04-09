class SellingProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :selling_products do |t|
      t.references :selling_product_class, null: false
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps
    end

    add_index :selling_products, :code, unique: true
  end
end
