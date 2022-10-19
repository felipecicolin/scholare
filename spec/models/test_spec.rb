RSpec.describe Test do
  describe "associations" do
    describe "user" do
      it { is_expected.to belong_to(:user) }
    end

    describe "student" do
      it { is_expected.to belong_to(:student) }
    end

    describe "school_class" do
      it { is_expected.to belong_to(:school_class) }
    end

    describe "questions" do
      it { is_expected.to have_many(:questions).dependent(:destroy) }
    end
  end
end
