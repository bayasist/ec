class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart
      t.references :selling_product
      t.integer :quantity, null: false, default: 0
      t.timestamps
    end
  end
end
