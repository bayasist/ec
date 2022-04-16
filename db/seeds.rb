# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

food_tax = TaxType.create!(name: "食料品")
normal_tax = TaxType.create!(name: "食料品以外")
zero_tax = TaxType.create!(name: "非課税品")

TaxRate.destroy_all
TaxRate.create!(tax_type: zero_tax, rate: 0, begin_at: Date.new(1900, 1, 1))
TaxRate.create!(tax_type: food_tax, rate: 0, begin_at: Date.new(1900, 1, 1), end_at: Date.new(1989, 3, 31))
TaxRate.create!(tax_type: food_tax, rate: 3, begin_at: Date.new(1989, 4, 1), end_at: Date.new(1997, 3, 31))
TaxRate.create!(tax_type: food_tax, rate: 5, begin_at: Date.new(1997, 4, 1), end_at: Date.new(2014, 3, 31))
TaxRate.create!(tax_type: food_tax, rate: 8, begin_at: Date.new(2014, 4, 1))
TaxRate.create!(tax_type: normal_tax, rate: 0, begin_at: Date.new(1900, 1, 1), end_at: Date.new(1989, 3, 31))
TaxRate.create!(tax_type: normal_tax, rate: 3, begin_at: Date.new(1989, 4, 1), end_at: Date.new(1997, 3, 31))
TaxRate.create!(tax_type: normal_tax, rate: 5, begin_at: Date.new(1997, 4, 1), end_at: Date.new(2014, 3, 31))
TaxRate.create!(tax_type: normal_tax, rate: 8, begin_at: Date.new(2014, 4, 1), end_at: Date.new(2019, 9, 30))
TaxRate.create!(tax_type: normal_tax, rate: 10, begin_at: Date.new(2019, 10, 1))

Warehouse.find_or_create_by!(name: "a")
AttachSellingProduct.where(product_id: 1).destroy_all
Product.find_by(id: 1)&.delete
rp = Product.find_or_initialize_by(id: 1)
rp.name = "a"
rp.save!

rp.stocks.each do |stock|
  stock.arrive!(1, {})
end

pc = SellingProductClass.find_or_initialize_by(code: "a")
pc.name = "a"
pc.save!

p = SellingProduct.find_or_initialize_by(code: "c")
p.selling_product_class = pc
p.name = "b"
p.price = 100
p.tax_type = normal_tax
p.price_type = "tax_inclusive_pricing"
p.save!
AttachSellingProduct.create!(product: rp, selling_product: p, quantity: 1)



(member = Member.find_or_initialize_by(email: "test@example.com")).update!(password: "testtest")
ShippingAddress.create(name: "test", postal_code: "1000001", prefecture: "東京都", city: "千代田区千代田", address_line: "1", building_name: "", member: member)
