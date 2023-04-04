RSpec.describe "Sign in and out" do
  let(:user) { create(:user) }

  it "successfully signs in" do
    visit new_user_session_path

    fill_in "E-mail", with: user.email
    fill_in "Senha", with: user.password

    click_button "Acessar"

    expect(page).to have_content("Entrou com sucesso.")
  end

  it "tries to sign in with invalid credentials" do
    visit new_user_session_path

    fill_in "E-mail", with: user.email
    fill_in "Senha", with: "wrong_password"

    click_button "Acessar"

    expect(page).to have_content("E-mail ou senha inválidos.")

    fill_in "E-mail", with: "wrong_email@example.com"
    fill_in "Senha", with: user.password

    click_button "Acessar"

    expect(page).to have_content("E-mail ou senha inválidos.")
  end

  it "tries to sign in with an unconfirmed account" do
    user = create(:user, confirmed_at: nil)

    visit new_user_session_path

    fill_in "E-mail", with: user.email
    fill_in "Senha", with: user.password

    click_button "Acessar"

    expect(page).to have_content("Antes de continuar, confirme a sua conta.")
  end

  it "successfully signs out" do
    sign_in user

    visit root_path

    find_button(user.email).click

    click_link "Sair"

    expect(page).to have_content("Saiu com sucesso.")
  end
end
