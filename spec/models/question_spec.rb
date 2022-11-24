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

    describe "at_least_one_correct_alternative_is_required" do
      it do
        question = build(:question, alternatives: [])
        question.validate
        expect(question.errors[:base]).to include("Deve haver pelo menos uma alternativa correta")
      end
    end

    describe "only_one_correct_alternative_is_permitted" do
      it do
        question = build(:question,
                         alternatives: [build(:alternative, correct: true), build(:alternative, correct: true)])
        question.validate
        expect(question.errors[:base]).to include("Só é permitido uma alternativa correta")
      end
    end
  end

  describe "associations" do
    describe "user" do
      it { is_expected.to belong_to(:user) }
    end

    describe "test" do
      it { is_expected.to belong_to(:test) }
    end

    describe "alternatives" do
      it { is_expected.to have_many(:alternatives).dependent(:destroy) }
    end
  end
end
