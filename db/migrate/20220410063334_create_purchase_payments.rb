class CreatePurchasePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_payments do |t|
      t.references :purchase, null: false
      t.integer :total_price, null: false 

      t.timestamps
    end
  end
end
