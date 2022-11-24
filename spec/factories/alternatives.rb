FactoryBot.define do
  factory :alternative do
    body { Faker::Lorem.sentence }
    option { %w[A B C D E].sample }
    correct { true }
  end
end
