FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    login_token { "MyString" }
    login_token_verified_at { Time.current }
  end
end
