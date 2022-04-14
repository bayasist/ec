class AddPurchasesToCarts < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :purchase, null: true
  end
end
