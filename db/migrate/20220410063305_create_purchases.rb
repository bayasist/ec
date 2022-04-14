class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :member, null: false
      t.string :code, null: false
      t.datetime :sold_at, null: false
      t.integer :price_with_tax
      t.integer :price_without_tax
      t.timestamps
    end
    add_index :purchases, :code, unique: false
  end
end
