RSpec.describe "No students alert" do
  it do
    user = create(:user)

    sign_in user
    visit tests_path

    expect(page).to have_content("Você deve ter pelo menos um aluno cadastrado para acessar essa página.")
  end
end
