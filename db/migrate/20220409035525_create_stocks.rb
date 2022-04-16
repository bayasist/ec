class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.references :product, null: false
      t.references :warehouse, null: false
      t.integer :quantity, null: false
      t.integer :allowable_quantity, null: false
      t.integer :process_quantity, null: false
      t.integer :bad_quantity, null: false
      t.integer :hold_quantity, null: false
      t.timestamps
    end
    add_index :stocks, [:product_id, :warehouse_id], unique: true
  end
end
