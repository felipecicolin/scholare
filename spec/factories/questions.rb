FactoryBot.define do
  factory :question do
    body { Faker::Lorem.paragraph }
    value { Faker::Number.decimal(l_digits: 1) }
    alternatives { build_list(:alternative, 1) }
    user
  end
end
