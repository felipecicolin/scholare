RSpec.describe Test do
  describe "associations" do
    describe "user" do
      it { is_expected.to belong_to(:user) }
    end

    describe "questions" do
      it { is_expected.to have_many(:questions).dependent(:destroy) }
    end
  end
end
