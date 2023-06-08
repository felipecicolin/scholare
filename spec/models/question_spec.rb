RSpec.describe Question do
  subject { create(:question, test: create(:school_test)) }

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
      it do
        test = create(:school_test)
        question = create(:question, test:)

        expect(question.user).to eq(test.user)
      end
    end

    describe "test" do
      it do
        test = create(:school_test)
        question = create(:question, test:)

        expect(question.test).to eq(test)
      end
    end

    describe "alternatives" do
      it { is_expected.to have_many(:alternatives).dependent(:destroy) }
    end
  end

  describe "callbacks" do
    describe "set_number" do
      it do
        test = create(:school_test)
        question = create(:question, test:)

        expect(question.number).to eq(1)
      end
    end

    describe "set_user" do
      it do
        test = create(:school_test)
        question = create(:question, test:)

        expect(question.user).to eq(test.user)
      end
    end

    describe "normalize_test_questions_numbers" do
      let(:test) { create(:school_test) }

      let!(:first_question) { create(:question, test:, number: 1) }
      let!(:second_question) { create(:question, test:, number: 2) }
      let!(:third_question) { create(:question, test:, number: 3) }

      before { second_question.destroy }

      it { expect(first_question.reload.number).to eq(1) }
      it { expect(third_question.reload.number).to eq(2) }
    end
  end
end
