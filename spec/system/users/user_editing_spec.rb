RSpec.describe "User Editing" do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  it "successfully edits the user's password" do
    fill_in "Senha", with: "new_password"
    fill_in "Confirmação da senha", with: "new_password"
    fill_in "Senha atual", with: user.password

    click_button "Atualizar"

    expect(page).to have_content("A sua conta foi atualizada com sucesso.")
  end

  it "successfully updates the user's e-mail" do
    fill_in "E-mail", with: "email@example.com"
    fill_in "Senha atual", with: user.password

    click_button "Atualizar"

    expect(page).to have_content("Sua conta foi atualizada com sucesso, mas nós precisamos " \
                                 "verificar o novo endereço de email. Por favor, verifique seu e-mail " \
                                 "e clique no link de confirmação para finalizar confirmando o seu novo e-mail.")
  end

  it "tries to edit user without confirming the current password" do
    fill_in "Senha", with: "new_password"
    fill_in "Confirmação da senha", with: "new_password"

    click_button "Atualizar"

    expect(page).to have_content("Senha atual não pode ficar em branco")
  end
end
