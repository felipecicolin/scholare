RSpec.describe "User Deleting" do
  it "successfully deletes the user's account" do
    sign_in create(:user)
    visit edit_user_registration_path

    click_button "Cancelar minha conta"

    expect(page).to have_content("A sua conta foi cancelada com sucesso.")
  end
end
