FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    confirmed_at { Time.current }
  end
end
