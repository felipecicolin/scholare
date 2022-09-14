RSpec.describe Alternative do
  describe "validations" do
    describe "option" do
      it { is_expected.to validate_presence_of(:option) }
    end

    describe "body" do
      it { is_expected.to validate_presence_of(:body) }
    end
  end

  describe "associations" do
    describe "question" do
      it { is_expected.to belong_to(:question) }
    end
  end
end
