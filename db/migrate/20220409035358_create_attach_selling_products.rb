class CreateAttachSellingProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :attach_selling_products do |t|
      t.references :selling_product, null: false
      t.references :product, null: false
      t.integer :quantity, null: false, default: 1
      t.timestamps
    end
    add_index :attach_selling_products, [:selling_product_id, :product_id], unique: true, name: :attach_selling_products_index
  end
end
