FactoryBot.define do
  factory :test_grade do
    test factory: :school_test
    student
    grade { Faker::Number.decimal(l_digits: 1) }
  end
end
