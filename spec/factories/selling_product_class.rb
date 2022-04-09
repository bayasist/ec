FactoryBot.define do
  factory :selling_product_class do
    name { Faker::Book.title }
    sequence(:code) {|n| n.to_s }
  end
end