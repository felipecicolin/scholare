FactoryBot.define do
  factory :question do
    body { Faker::Lorem.paragraph }
    value { 1.0 }
    school_class
    student
  end
end
