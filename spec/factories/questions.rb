FactoryBot.define do
  factory :question do
    body { Faker::Lorem.paragraph }
    value { Faker::Number.decimal(l_digits: 1) }
  end
end
