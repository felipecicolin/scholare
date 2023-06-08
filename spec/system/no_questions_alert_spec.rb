RSpec.describe "No questions alert" do
  it do
    user = create(:user, students: create_list(:student, 1))
    test = create(:school_test, user:)

    sign_in test.user
    visit pdf_tests_path(test_id: test.id)

    expect(page).to have_content("Você deve adicionar questões para gerar a prova ou o gabarito.")

    visit pdf_templates_path(test_id: test.id)

    expect(page).to have_content("Você deve adicionar questões para gerar a prova ou o gabarito.")
  end
end
