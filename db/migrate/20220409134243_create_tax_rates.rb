class CreateTaxRates < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_rates do |t|
      t.references :tax_type, null: false
      t.date :begin_at, null: false
      t.date :end_at, null: true
      t.decimal :rate, null: false
      t.timestamps
    end
  end
end
