RSpec.describe SchoolClass do
  describe "validations" do
    describe "name" do
      it { is_expected.to validate_presence_of(:name) }

      it "validates uniqueness of name scoped to user" do
        first_class = create(:school_class, name: "First Class", user: create(:user))
        second_class = build(:school_class, name: "First Class", user: first_class.user)
        second_class.valid?

        expect(second_class.errors[:name]).to include("já está em uso")
      end

      it "allows the same name for different users" do
        create(:school_class, name: "First Class", user: create(:user))

        school_class = build(:school_class, name: "First Class", user: create(:user))
        school_class.valid?

        expect(school_class.errors[:name]).to be_empty
      end
    end
  end

  describe "associations" do
    describe "user" do
      it { is_expected.to belong_to(:user) }
    end

    describe "students" do
      it { is_expected.to have_many(:students).dependent(:destroy) }
    end

    describe "tests" do
      it { is_expected.to have_many(:tests).dependent(:destroy) }
    end
  end
end
