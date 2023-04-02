RSpec.describe "School Tests CRUD" do
  let(:user) { create(:user, school_classes: [first_class, second_class]) }

  let(:first_class) { create(:school_class, name: "First Class") }
  let(:second_class) { create(:school_class, name: "Second Class") }

  before do
    sign_in user
    create(:student, user:, school_class: first_class)
    create(:student, user:, school_class: second_class)
  end

  describe "Test creation" do
    it "successfully creates a new Test" do
      visit new_test_path

      click_button "Cadastrar Prova"

      expect(page).to have_content("Nome não pode ficar em branco")
      expect(page).to have_content("Turma é obrigatório(a)")
      expect(page).to have_content("Data deve estar no futuro")
      expect(page).to have_content("Valor não pode ficar em branco e Valor não é um número")

      fill_in "Nome", with: "Math Test"

      select "First Class", from: "Turma"

      select "30", from: "test_test_date_3i"
      find_by_id("test_test_date_2i").click

      select "dezembro", from: "test_test_date_2i"
      select "2027", from: "test_test_date_1i"

      fill_in "Valor", with: "10"

      click_on "Cadastrar Prova"

      expect(page).to have_content("Prova criada com sucesso")
      expect(Test.count).to eq(1)
    end
  end

  describe "Test edition" do
    it "successfully updates a Test" do
      test = create(:school_test, school_class: first_class,
                                  user:,
                                  name: "Portuguese Test",
                                  test_date: "Fri, 31 Dec 2027".to_date,
                                  value: 10)

      visit edit_test_path(id: test.id)

      fill_in "Nome", with: ""

      select "Second Class", from: "Turma"

      select "30", from: "test_test_date_3i"
      select "dezembro", from: "test_test_date_2i"
      select "2027", from: "test_test_date_1i"

      fill_in "Valor", with: "10"

      click_button "Atualizar Prova"

      expect(page).to have_content("Nome não pode ficar em branco")

      fill_in "Nome", with: "Math Test"

      click_button "Atualizar Prova"

      expect(page).to have_content("Prova atualizada com sucesso")

      expect(Test.count).to eq(1)

      expect(test.reload.name).to eq("Math Test")
      expect(test.reload.school_class).to eq(second_class)
      expect(test.reload.test_date).to eq("Thu, 30 Dec 2027".to_date)
      expect(test.reload.value).to eq(10)
    end
  end

  describe "Test deletion" do
    it "successfully deletes a Test" do
      test = create(:school_test, user:)
      visit edit_test_path(id: test.id)
      click_on "Remover"

      expect(page).to have_content("Prova removida com sucesso")
      expect(Test.count).to eq(0)
    end
  end

  describe "Tests List" do
    it "successfully lists all current user's Tests" do
      first_test = create(:school_test, user:, name: "First Test", school_class: first_class)
      second_test = create(:school_test, user:, name: "Second Test", school_class: second_class)

      create(:school_test, name: "Other User's Test", school_class: create(:school_class, name: "Other Class"))

      visit tests_path

      expect(page).to have_link("First Test", href: edit_test_path(id: first_test.id))
      expect(page).to have_link("Second Test", href: edit_test_path(id: second_test.id))

      expect(page).to have_content("First Class")
      expect(page).to have_content("Second Class")

      expect(page).not_to have_content("Other User's Test")
      expect(page).not_to have_content("Other Class")

      expect(page).to have_link("Gerenciar questões", href: test_questions_path(test_id: first_test.id))
      expect(page).to have_link("Gerenciar questões", href: test_questions_path(test_id: second_test.id))

      expect(page).to have_link("Adicionar", href: new_test_path)
    end

    context "when there are no Tests" do
      it "shows an info message" do
        visit tests_path

        expect(page).to have_content("Não há nenhum registro")
      end
    end
  end

  describe "Tests filtering" do
    it "successfully filters Tests by School Class" do
      create(:school_test, user:, name: "First Test", school_class: first_class)
      create(:school_test, user:, name: "Second Test", school_class: second_class)

      visit tests_path

      select "First Class", from: "q_school_class_id_eq"

      expect(page).to have_selector("tr", text: "First Test")
      expect(page).not_to have_selector("tr", text: "Second Test")

      select "Second Class", from: "q_school_class_id_eq"

      expect(page).not_to have_selector("tr", text: "First Test")
      expect(page).to have_selector("tr", text: "Second Test")

      select "Encontre suas provas por turma:", from: "q_school_class_id_eq"

      expect(page).to have_selector("tr", text: "First Test")
      expect(page).to have_selector("tr", text: "Second Test")
    end
  end

  describe "Tests pagination" do
    it "successfully paginates Tests" do
      create_list(:school_test, 7, user:, school_class: first_class)

      visit tests_path

      expect(page).to have_selector("tr", count: 6)

      click_on "Próximo"

      expect(page).to have_selector("tr", count: 3)
    end
  end
end
