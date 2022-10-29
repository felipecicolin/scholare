RSpec.describe Test do
  describe "validations" do
    #   describe "name" do
    #     it { is_expected.to validate_presence_of(:name) }

    #     it "validates uniqueness of name scoped to user" do
    #       first_test = create(:test, name: "First Test", user: create(:user))
    #       second_test = build(:test, name: "First Test", user: first_test.user)
    #       second_test.valid?

    #       expect(second_test.errors[:name]).to include("já está em uso")
    #     end

    #     it "allows the same name for different users" do
    #       create(:test, name: "First Test", user: create(:user))

    #       school_class = build(:test, name: "First Test", user: create(:user))
    #       school_class.valid?

    #       expect(school_class.errors[:name]).to be_empty
    #     end
    #   end

    describe "test_date" do
      it { is_expected.to validate_presence_of(:test_date) }
    end
  end

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
