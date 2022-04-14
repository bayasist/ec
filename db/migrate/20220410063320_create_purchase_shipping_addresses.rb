class CreatePurchaseShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_shipping_addresses do |t|
      t.references :purchase, null: false
      t.references :shipping_address, null: false
      t.string :name
      t.string :prefecture
      t.string :city
      t.string :address_line
      t.string :building_name
      t.timestamps
    end
  end
end
