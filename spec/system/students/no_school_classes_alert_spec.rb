RSpec.describe "No school classes alert" do
  it do
    user = create(:user)
    create(:student, user:)

    sign_in user
    visit students_path

    expect(page).to have_content("Você deve ter pelo menos uma turma cadastrada para acessar essa página.")
  end
end
