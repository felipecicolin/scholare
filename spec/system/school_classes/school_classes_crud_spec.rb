RSpec.describe "School Classes CRUD" do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "School Class creation" do
    it "successfully creates a new School Class" do
      visit new_user_school_class_path(user_id: user.id)

      fill_in "Nome da turma", with: "9th Grade"
      click_button "Cadastrar"

      expect(page).to have_content("Turma criada com sucesso")
      expect(SchoolClass.count).to eq(1)
    end
  end

  describe "School Class edition" do
    it "successfully updates a School Class" do
      school_class = create(:school_class, user:, name: "Example Class")
      visit edit_user_school_class_path(user_id: user.id, id: school_class.id)

      fill_in "Nome da turma", with: "Updated Class"
      click_button "Editar"

      expect(page).to have_content("Turma atualizada com sucesso")
      expect(SchoolClass.count).to eq(1)
      expect(SchoolClass.first.name).to eq("Updated Class")
    end
  end

  describe "School Class deletion" do
    it "successfully deletes a School Class" do
      create(:school_class, user:)
      visit user_school_classes_path(user_id: user.id)

      click_on "Remover"

      expect(page).to have_content("Turma removida com sucesso")
      expect(SchoolClass.count).to eq(0)
    end
  end

  describe "School Classes List" do
    it "successfully lists all current user's School Classes" do
      first_class = create(:school_class, user:, name: "First Class")
      second_class = create(:school_class, user:, name: "Second Class")

      visit user_school_classes_path(user_id: user.id)

      expect(page).to have_content("First Class")
      expect(page).to have_content("Second Class")

      expect(page).to have_link("Editar", href: edit_user_school_class_path(user_id: user.id,
                                                                            id: first_class.id))

      expect(page).to have_link("Editar", href: edit_user_school_class_path(user_id: user.id,
                                                                            id: second_class.id))

      expect(page).to have_button("Remover", count: 2)

      expect(page).to have_link("Adicionar", href: new_user_school_class_path(user_id: user.id))
      expect(page).to have_link("Voltar", href: root_path)
    end
  end
end
