user = User.create(
  email: "felipe@scholare.com",
  password: "scholare123",
  password_confirmation: "scholare123",
  confirmed_at: Time.current
)

5.times do
  SchoolClass.create(
    name: Faker::Educator.course,
    user: user
  )
end

SchoolClass.all.each do |school_class|
  15.times do
    Student.create(
      name: Faker::Name.name,
      identifier: Faker::Number.unique.number(digits: 10),
      school_class: school_class,
      user: user
    )
  end
end
