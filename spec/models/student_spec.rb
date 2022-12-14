RSpec.describe Student do
  describe "validations" do
    describe "name" do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe "identifier" do
      it { is_expected.to validate_presence_of(:identifier) }

      it "validates uniqueness" do
        student = create(:student)
        secondary_student = build(:student, identifier: student.identifier)
        secondary_student.save

        expect(secondary_student.errors[:identifier]).to include("já está em uso")
      end
    end
  end

  describe "associations" do
    describe "user" do
      it { is_expected.to belong_to(:user) }
    end

    describe "school_class" do
      it { is_expected.to belong_to(:school_class) }
    end

    describe "tests" do
      it { is_expected.to have_many(:tests).through(:school_class) }
    end

    describe "test_grades" do
      it { is_expected.to have_many(:test_grades).dependent(:destroy) }
    end
  end
end
