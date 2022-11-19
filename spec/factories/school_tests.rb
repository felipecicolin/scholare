FactoryBot.define do
  factory :school_test, class: "Test" do
    user
    school_class
    questions { build_list(:question, 3) }
    name { Faker::Lorem.sentence }
    value { Faker::Number.decimal(l_digits: 1) }
    test_date { Faker::Date.between(from: 1.day.from_now, to: 1.month.from_now) }
  end
end
