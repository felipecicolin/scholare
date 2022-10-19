RSpec.describe "School Classes CRUD" do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "School Class creation" do
    it "successfully creates a new School Class" do
      visit new_school_class_path

      click_button "Cadastrar Turma"
      expect(page).to have_content("Nome da turma não pode ficar em branco")

      fill_in "Nome da turma", with: "9th Grade"
      click_button "Cadastrar Turma"

      expect(page).to have_content("Turma criada com sucesso")
      expect(SchoolClass.count).to eq(1)
    end
  end

  describe "School Class edition" do
    it "successfully updates a School Class" do
      school_class = create(:school_class, user:, name: "Example Class")
      visit edit_school_class_path(id: school_class.id)

      fill_in "Nome da turma", with: ""
      click_button "Atualizar Turma"

      expect(page).to have_content("Nome da turma não pode ficar em branco")

      fill_in "Nome da turma", with: "Updated Class"
      click_button "Atualizar Turma"

      expect(page).to have_content("Turma atualizada com sucesso")
      expect(SchoolClass.count).to eq(1)
      expect(school_class.reload.name).to eq("Updated Class")
    end
  end

  describe "School Class deletion" do
    it "successfully deletes a School Class" do
      create(:school_class, user:)
      visit school_classes_path

      click_on "Remover"

      expect(page).to have_content("Turma removida com sucesso")
      expect(SchoolClass.count).to eq(0)
    end
  end

  describe "School Classes List" do
    it "successfully lists all current user's School Classes" do
      first_class = create(:school_class, user:, name: "First Class")
      second_class = create(:school_class, user:, name: "Second Class")

      create(:school_class, name: "Other User's Class")

      visit school_classes_path

      expect(page).to have_content("First Class")
      expect(page).to have_content("Second Class")
      expect(page).not_to have_content("Other User's Class")

      expect(page).to have_link("Editar", href: edit_school_class_path(id: first_class.id))
      expect(page).to have_link("Editar", href: edit_school_class_path(id: second_class.id))
      expect(page).to have_link("Adicionar", href: new_school_class_path)
      expect(page).to have_button("Remover", count: 2)
    end

    context "when there are no School Classes" do
      it "shows an info message" do
        visit school_classes_path

        expect(page).to have_content("Não há nenhum registro")
      end
    end
  end

  describe "Students pagination" do
    it "successfully paginates Students" do
      create_list(:school_class, 7, user:)

      visit school_classes_path

      expect(page).to have_selector("tr", count: 6)

      click_on "Próximo"

      expect(page).to have_selector("tr", count: 3)
    end
  end
end
