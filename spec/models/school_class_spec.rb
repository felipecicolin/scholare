RSpec.describe SchoolClass do
  describe "validations" do
    describe "name" do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  describe "associations" do
    describe "user" do
      it { is_expected.to belong_to(:user) }
    end
  end
end
