class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_methods do |t|
      t.integer :index, null: false
      t.references :member, null: false
      t.string :stripe_paymen_method_id, null: false
      t.timestamps
    end
    add_index :payment_methods, [:member_id, :index], unique: true
    add_column :members, :default_payment_method_id, :bigint, after: :encrypted_password
    add_foreign_key :members, :payment_methods, column: :default_payment_method_id
    add_reference :carts, :payment_method
    add_reference :purchase_payments, :payment_method, after: :total_price, null: false
    add_column :purchase_payments, :stripe_payment_id, :string, after: :payment_method_id
  end
end
