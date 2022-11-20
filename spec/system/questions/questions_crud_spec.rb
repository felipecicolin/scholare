RSpec.describe "Questions CRUD" do
  let(:user) { create(:user, school_classes: [school_class]) }
  let(:school_class) { create(:school_class, name: "Example Class") }
  let(:school_test) { create(:school_test, school_class:, user:, name: "Example Test") }

  before { sign_in user }

  describe "Question creation" do
    it "successfully creates a new Question" do
      visit new_test_question_path(test_id: school_test.id)

      click_button "Cadastrar Questão"

      expect(page).to have_content("Enunciado não pode ficar em branco")
      expect(page).to have_content("Valor da questão não pode ficar em branco e Valor da questão não é um número")

      fill_in "Enunciado", with: "How many apples are there in the basket?"
      fill_in "Valor da questão", with: "1"

      click_on "Cadastrar Questão"

      expect(page).to have_content("Questão criada com sucesso")
      expect(Question.count).to eq(1)
    end
  end

  describe "Question edition" do
    it "successfully updates a Question" do
      question = create(:question, test: school_test, user:)

      visit edit_test_question_path(test_id: school_test.id, id: question.id)

      fill_in "Enunciado", with: ""
      fill_in "Valor da questão", with: ""

      click_button "Atualizar Questão"

      expect(page).to have_content("Enunciado não pode ficar em branco")
      expect(page).to have_content("Valor da questão não pode ficar em branco e Valor da questão não é um número")

      fill_in "Enunciado", with: "How many apples are there in the basket?"
      fill_in "Valor da questão", with: "1"

      click_button "Atualizar Questão"

      expect(page).to have_content("Questão atualizada com sucesso")

      expect(Question.count).to eq(1)

      expect(question.reload.body).to eq("How many apples are there in the basket?")
      expect(question.reload.value).to eq(1)
    end
  end

  describe "Question deletion" do
    it "successfully deletes a Question" do
      create(:question, test: school_test, user:)
      visit test_questions_path(test_id: school_test.id)
      click_on "Remover"

      expect(page).to have_content("Questão removida com sucesso")
      expect(Question.count).to eq(0)
    end
  end

  describe "Questions listing" do
    it "successfully lists all current user's tests' Questions" do
      question = create(:question, test: school_test, user:,
                                   body: "First Question", value: 1)

      visit test_questions_path(test_id: school_test.id)

      expect(page).to have_content("First Question")
      expect(page).to have_content("1.0")
      expect(page).to have_content("Example Test")

      expect(page).to have_link("Editar", href: edit_test_question_path(test_id: school_test.id, id: question.id))
      expect(page).to have_link("Adicionar", href: new_test_question_path(test_id: school_test.id))
      expect(page).to have_button("Remover")
    end
  end

  describe "Questions pagination" do
    it "successfully paginates Questions" do
      create_list(:question, 7, user:, test: school_test)

      visit test_questions_path(test_id: school_test.id)

      expect(page).to have_selector("tr", count: 6)

      click_on "Próximo"

      expect(page).to have_selector("tr", count: 3)
    end
  end
end
