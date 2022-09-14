RSpec.describe Question do
  describe "validations" do
    describe "body" do
      it { is_expected.to validate_presence_of(:body) }
    end

    describe "value" do
      it { is_expected.to validate_presence_of(:value) }
      it { is_expected.to validate_numericality_of(:value).is_greater_than(0) }
      it { is_expected.to allow_value(1).for(:value) }
      it { is_expected.to allow_value(1.5).for(:value) }
      it { is_expected.not_to allow_value(0).for(:value) }
      it { is_expected.not_to allow_value(-1).for(:value) }
    end

    describe "essay_question" do
      it { is_expected.to allow_value(true).for(:essay_question) }
      it { is_expected.to allow_value(false).for(:essay_question) }
      it { is_expected.not_to allow_value(nil).for(:essay_question) }
    end
  end

  describe "associations" do
    describe "test" do
      it { is_expected.to belong_to(:test) }
    end

    describe "alternatives" do
      it { is_expected.to have_many(:alternatives).dependent(:destroy) }
    end
  end
end
