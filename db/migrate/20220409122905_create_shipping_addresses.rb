class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.integer :index, null: false
      t.references :member, null: false
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address_line, null: false
      t.string :building_name, null: false
      t.timestamps
    end
    add_index :shipping_addresses, [:member_id, :index], unique: true

    add_column :members, :default_shipping_address_id, :bigint, after: :encrypted_password
    add_foreign_key :members, :shipping_addresses, column: :default_shipping_address_id

    add_reference :carts, :shipping_address
  end
end
