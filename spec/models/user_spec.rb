RSpec.describe User do
  describe "validations" do
    describe "email" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.not_to allow_value("example").for(:email) }
      it { is_expected.to allow_value("example@example.com").for(:email) }
    end

    describe "password" do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_confirmation_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(8) }
    end
  end

  describe "associations" do
    describe "tests" do
      it { is_expected.to have_many(:tests).dependent(:destroy) }
    end

    describe "school_classes" do
      it { is_expected.to have_many(:school_classes).dependent(:destroy) }
    end

    describe "students" do
      it { is_expected.to have_many(:students).dependent(:destroy) }
    end
  end
end
