class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.references :product
      t.references :warehouse
      t.integer :quantity
      t.integer :allowable_quantity
      t.integer :process_quantity
      t.integer :bad_quantity
      t.integer :hold_quantity
      t.timestamps
    end
    add_index :stocks, [:product_id, :warehouse_id], unique: true
  end
end
