# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

pc = SellingProductClass.find_or_initialize_by(code: "a")
pc.name = "a"
pc.save!

p = SellingProduct.find_or_initialize_by(code: "c")
p.selling_product_class = pc
p.name = "b"
p.save!


Member.create!(email: "test@example.com", password: "testtest")