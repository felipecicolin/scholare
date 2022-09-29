RSpec.describe "User Deleting" do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  it "successfully deletes the user's account" do
    click_button "Cancelar minha conta"

    expect(page).to have_content("A sua conta foi cancelada com sucesso.")
  end
end
