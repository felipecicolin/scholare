RSpec.describe TestGrade do
  describe "validations" do
    it { is_expected.to validate_presence_of(:grade) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:test) }
    it { is_expected.to belong_to(:student) }
  end
end
