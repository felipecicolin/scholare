FactoryBot.define do
  factory :question do
    body { Faker::Lorem.paragraph }
    value { Faker::Number.decimal(l_digits: 1) }

    alternatives do
      [
        build(:alternative, correct: true, option: "A"),
        build(:alternative, correct: false, option: "B"),
        build(:alternative, correct: false, option: "C"),
        build(:alternative, correct: false, option: "D"),
        build(:alternative, correct: false, option: "E")
      ]
    end

    test factory: :school_test
  end
end
