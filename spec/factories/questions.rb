FactoryBot.define do
  factory :question do
    body { Faker::Lorem.paragraph }
    value { Faker::Number.decimal(l_digits: 1) }

    alternatives do
      [
        build(:alternative, correct: true),
        build(:alternative, correct: false),
        build(:alternative, correct: false),
        build(:alternative, correct: false),
        build(:alternative, correct: false)
      ]
    end

    test { create(:school_test, user:) }
    user
  end
end
