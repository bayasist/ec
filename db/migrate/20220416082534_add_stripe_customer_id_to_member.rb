class AddStripeCustomerIdToMember < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :stripe_customer_id, :string, null: true
  end
end
