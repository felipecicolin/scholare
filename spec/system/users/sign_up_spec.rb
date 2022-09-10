RSpec.describe "Sign Up" do
  before { visit new_user_registration_path }

  it "successfully signs up" do
    fill_in "E-mail", with: "example@example.com"
    fill_in "Senha", with: "example_password"
    fill_in "Confirmação da senha", with: "example_password"

    click_button "Criar conta"

    expect(page).to have_content("Uma mensagem com um link de confirmação foi enviada para o seu " \
                                 "e-mail. Por favor, acesse o link para ativar sua conta.")

    user = User.find_by(email: "example@example.com")

    visit user_confirmation_path(confirmation_token: user.confirmation_token)

    expect(page).to have_content("A sua conta foi confirmada com sucesso.")
  end

  it "tries to sign up with invalid data" do
    fill_in "E-mail", with: "example"
    fill_in "Senha", with: "example_password"
    fill_in "Confirmação da senha", with: "example_password"

    click_button "Criar conta"

    expect(page).to have_content("E-mail não é válido")

    fill_in "E-mail", with: "example@example.com"
    fill_in "Senha", with: "example"
    fill_in "Confirmação da senha", with: "example"

    click_button "Criar conta"

    expect(page).to have_content("Senha deve ter pelo menos 8 caracteres")

    fill_in "E-mail", with: "example@example.com"
    fill_in "Senha", with: "example_password"
    fill_in "Confirmação da senha", with: "not_matching_password"

    click_button "Criar conta"

    expect(page).to have_content("Confirmação da senha não é igual a Senha")
  end

  it "tries to sign up with an already registered e-mail" do
    create(:user, email: "example@example.com")

    fill_in "E-mail", with: "example@example.com"
    fill_in "Senha", with: "example_password"
    fill_in "Confirmação da senha", with: "example_password"

    click_button "Criar conta"

    expect(page).to have_content("E-mail já está em uso")
  end
end
