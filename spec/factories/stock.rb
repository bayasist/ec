FactoryBot.define do
  factory :stock do
    quantity { 0 }
    allowable_quantity { 0 }
    process_quantity { 0 }
    bad_quantity { 0 }
    hold_quantity { 0 }
  end
end