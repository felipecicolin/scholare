user = User.create!(
  email: "dev@scholare.com",
  password: "scholare123",
  password_confirmation: "scholare123",
  confirmed_at: Time.current
)

4.times do
  SchoolClass.create!(
    name: Faker::Educator.unique.course,
    user: user
  )
end

SchoolClass.all.each do |school_class|
  7.times do
    Student.create!(
      name: Faker::Name.name,
      identifier: Faker::Number.unique.number(digits: 10),
      school_class: school_class,
      user: user
    )
  end

  Test.create!(
    name: Faker::Educator.unique.subject,
    school_class: school_class,
    user: user,
    value: 10,
    test_date: Faker::Date.forward(days: 30)
  )
end

Test.all.each do |test|
  5.times do
    Question.create!(
      body: Faker::Lorem.paragraph(sentence_count: 5),
      value: 1,
      test: test,
      user: user,
      alternatives: [
        Alternative.new(body: Faker::Lorem.paragraph, correct: true),
        Alternative.new(body: Faker::Lorem.paragraph, correct: false),
        Alternative.new(body: Faker::Lorem.paragraph, correct: false),
        Alternative.new(body: Faker::Lorem.paragraph, correct: false),
        Alternative.new(body: Faker::Lorem.paragraph, correct: false)
      ]
    )
  end
end
