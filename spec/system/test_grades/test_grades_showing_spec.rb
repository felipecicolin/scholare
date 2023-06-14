RSpec.describe "Test Grades Showing" do
  let!(:student) { create(:student, identifier: "123456789", name: "Example Student") }

  before { visit test_grades_path }

  it do
    create(:test_grade, student:, test: create(:school_test, name: "Example Test"), grade: 10.0)

    find_by_id("identifier").fill_in(with: "123456789")

    click_button "Pesquisar"

    expect(page).to have_content("Example Student")
    expect(page).to have_content("10.0")
    expect(page).to have_content("Example Test")
  end

  context "when there are no test grades" do
    it do
      click_button "Pesquisar"

      find_by_id("identifier").fill_in(with: "123456789")

      click_button "Pesquisar"

      expect(page).to have_content("Nenhuma nota foi encontrada")
    end
  end

  context "when the student is not found" do
    it do
      find_by_id("identifier").fill_in(with: "123")

      click_button "Pesquisar"

      expect(page).to have_content("Nenhum aluno com o identificador 123 foi encontrado")
    end
  end

  context "when the search field is blank" do
    it do
      click_button "Pesquisar"

      expect(page).to have_content("O campo de busca não pode ficar em branco")
    end
  end
end
