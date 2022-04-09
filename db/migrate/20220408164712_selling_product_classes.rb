class SellingProductClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :selling_product_classes do |t|
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps
    end

    add_index :selling_product_classes, :code, unique: true
  end
end
