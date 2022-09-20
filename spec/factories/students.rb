FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    identifier { Faker::Number.number(digits: 10) }
    school_class
  end
end
