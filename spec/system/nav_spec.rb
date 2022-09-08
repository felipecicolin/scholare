RSpec.describe "Nav" do
  describe "signed out" do
    it do
      visit root_path

      expect(page).to have_link("Entrar", href: new_account_session_path)
      expect(page).to have_link("Cadastrar", href: new_account_registration_path)
    end
  end

  describe "signed in" do
    it do
      account = create(:account)
      sign_in account

      visit root_path

      find("button", text: account.email).click

      expect(page).to have_link("Editar conta", href: edit_account_registration_path)
      expect(page).to have_selector("button", text: "Sair")
    end
  end
end
