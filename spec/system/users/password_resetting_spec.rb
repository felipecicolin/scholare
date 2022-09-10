RSpec.describe "Password Resetting" do
  let(:user) { create(:user) }

  it "requests a password resetting e-mail" do
    visit new_user_password_path

    click_button "Enviar instruções para redefinição da senha"

    expect(page).to have_content("Por favor, verifique os problemas abaixo:")
    expect(page).to have_content("E-mail não pode ficar em branco")

    fill_in "E-mail", with: user.email
    click_button "Enviar instruções para redefinição da senha"

    expect(page).to have_content("Dentro de minutos, você receberá um e-mail com as " \
                                 "instruções de redefinição da sua senha.")
  end

  it "resets the password" do
    raw_token, encrypted_token = Devise.token_generator.generate(
      User,
      :reset_password_token
    )

    user.update(reset_password_token: encrypted_token, reset_password_sent_at: Time.current)

    visit edit_user_password_path(reset_password_token: raw_token)

    fill_in "Nova senha", with: "new_password"
    fill_in "Confirme sua nova senha", with: "password"

    click_button "Alterar minha senha"

    expect(page).to have_content("Por favor, verifique os problemas abaixo:")
    expect(page).to have_content("Confirmação da senha não é igual a Senha")

    fill_in "Nova senha", with: "new_password"
    fill_in "Confirme sua nova senha", with: "new_password"

    click_button "Alterar minha senha"

    expect(page).to have_content("A sua senha foi alterada com sucesso. Você está autenticado.")
  end
end
