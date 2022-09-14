RSpec.describe Alternative do
  describe "validations" do
    describe "option" do
      it { is_expected.to validate_presence_of(:option) }
      it { is_expected.to allow_value("A").for(:option) }
      it { is_expected.to allow_value("B").for(:option) }
      it { is_expected.to allow_value("C").for(:option) }
      it { is_expected.to allow_value("D").for(:option) }
      it { is_expected.to allow_value("E").for(:option) }
      it { is_expected.not_to allow_value("F").for(:option) }
    end

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
