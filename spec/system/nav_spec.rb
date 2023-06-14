RSpec.describe "Nav" do
  describe "signed out" do
    it do
      visit root_path

      expect(page).to have_link("Entrar", href: new_user_session_path)
      expect(page).to have_link("Cadastrar", href: new_user_registration_path)
      expect(page).to have_link("Consulte suas notas", href: test_grades_path)
    end
  end

  describe "signed in" do
    it do
      user = create(:user)
      sign_in user

      visit root_path

      click_button user.email

      expect(page).to have_link("Editar conta", href: edit_user_registration_path)
      expect(page).to have_link("Sair", href: destroy_user_session_path)
      expect(page).not_to have_link("Consulte suas notas", href: test_grades_path)
    end
  end
end
