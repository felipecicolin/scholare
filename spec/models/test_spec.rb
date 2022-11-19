RSpec.describe Test do
  describe "validations" do
    describe "name" do
      it { is_expected.to validate_presence_of(:name) }

      it "validates uniqueness of name scoped to user" do
        first_test = create(:school_test, name: "First Test", user: create(:user))
        second_test = build(:school_test, name: "First Test", user: first_test.user)
        second_test.valid?

        expect(second_test.errors[:name]).to include("já está em uso")
      end

      it "allows the same name for different users" do
        create(:school_test, name: "First Test", user: create(:user))

        school_class = build(:school_test, name: "First Test", user: create(:user))
        school_class.valid?

        expect(school_class.errors[:name]).to be_empty
      end
    end

    describe "test_date" do
      it { is_expected.to validate_presence_of(:test_date) }
    end

    describe "ensure_test_date_is_in_the_future" do
      it do
        test = build(:school_test, test_date: Time.zone.tomorrow)
        test.validate

        expect(test.errors[:test_date]).not_to include("deve estar no futuro")
      end

      it do
        test = build(:school_test, test_date: Time.zone.today)
        test.validate

        expect(test.errors[:test_date]).to include("deve estar no futuro")
      end

      it do
        test = build(:school_test, test_date: Time.zone.yesterday)
        test.validate

        expect(test.errors[:test_date]).to include("deve estar no futuro")
      end
    end
  end

  describe "associations" do
    describe "user" do
      it { is_expected.to belong_to(:user) }
    end

    describe "student" do
      it { is_expected.to belong_to(:student).optional }
    end

    describe "school_class" do
      it { is_expected.to belong_to(:school_class) }
    end

    describe "questions" do
      it { is_expected.to have_many(:questions).dependent(:destroy) }
    end
  end
end
