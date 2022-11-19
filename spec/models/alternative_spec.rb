RSpec.describe Alternative do
  describe "validations" do
    describe "body" do
      it { is_expected.to validate_presence_of(:body) }
    end

    describe "correct" do
      it { is_expected.to allow_value(true).for(:correct) }
      it { is_expected.to allow_value(false).for(:correct) }
    end
  end

  describe "associations" do
    describe "question" do
      it { is_expected.to belong_to(:question) }
    end
  end
end
