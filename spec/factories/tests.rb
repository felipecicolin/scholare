FactoryBot.define do
  factory :test do
    subject { "math" }
    questions { build_list(:question, 3) }
  end
end
