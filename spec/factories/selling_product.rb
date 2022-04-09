FactoryBot.define do
  factory :selling_product do
    name { Faker::Book.title }
    sequence(:code) {|n| n.to_s }
  end
end