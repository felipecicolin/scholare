FactoryBot.define do
  factory :alternative do
    body { Faker::Lorem.sentence }
    correct { true }
  end
end
