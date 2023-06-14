RSpec.describe TestGrade do
  describe "validations" do
    it { is_expected.to validate_presence_of(:grade) }
    it { is_expected.to validate_numericality_of(:grade).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:test) }
    it { is_expected.to belong_to(:student) }
  end
end
