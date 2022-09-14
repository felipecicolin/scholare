FactoryBot.define do
  factory :test do
    questions { build_list(:question, 3) }
  end
end
