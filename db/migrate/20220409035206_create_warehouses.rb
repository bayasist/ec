class CreateWarehouses < ActiveRecord::Migration[7.0]
  def change
    create_table :warehouses do |t|
      t.string :name, null: false
      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
