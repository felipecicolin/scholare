FactoryBot.define do
  factory :school_class do
    name { Faker::Educator.course_name }
    user
  end
end
