class CreateStockRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_records do |t|
      t.references :product
      t.references :warehouse
      t.integer :quantity
      t.integer :allowable_quantity
      t.integer :process_quantity
      t.integer :bad_quantity
      t.integer :hold_quantity
      t.integer :increase
      t.integer :allowable_increase
      t.integer :process_increase
      t.integer :bad_increase
      t.integer :hold_increase
      t.string :note
      t.timestamps
    end
  end
end
