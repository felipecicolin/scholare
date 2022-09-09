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
end
