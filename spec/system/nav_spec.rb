RSpec.describe "Nav" do
  describe "signed out" do
    it do
      visit root_path

      expect(page).to have_link("Entrar", href: new_user_session_path)
      expect(page).to have_link("Cadastrar", href: new_user_registration_path)
    end
  end

  describe "signed in" do
    it do
      user = create(:user)
      sign_in user

      visit root_path

      find("button", text: user.email).click

      expect(page).to have_link("Editar conta", href: edit_user_registration_path)
      expect(page).to have_button("Sair")
      expect(page).to have_link("Acessar Painel", href: panel_index_path)
    end
  end
end
