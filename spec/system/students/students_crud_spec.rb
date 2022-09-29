RSpec.describe "Students CRUD" do
  let(:user) { create(:user, school_classes: [first_class, second_class]) }
  let(:first_class) { create(:school_class, name: "Class 1") }
  let(:second_class) { create(:school_class, name: "Class 2") }

  before { sign_in user }

  describe "Student creation" do
    it "successfully creates a new Student" do
      visit new_student_path

      fill_in "Nome do aluno", with: "John Doe"
      fill_in "Identificador do aluno", with: "12345"
      select "Class 1", from: "Turma"

      click_on "Cadastrar Aluno"

      expect(page).to have_content("Aluno criado com sucesso")
      expect(Student.count).to eq(1)
    end
  end

  describe "Student edition" do
    it "successfully updates a Student" do
      student = create(:student, school_class: first_class,
                                 user: user,
                                 name: "John Doe",
                                 identifier: "12345")

      visit edit_student_path(id: student.id)

      fill_in "Nome do aluno", with: "Updated John Doe"
      fill_in "Identificador do aluno", with: "54321"
      select "Class 2", from: "Turma"

      click_button "Atualizar Aluno"

      expect(page).to have_content("Aluno atualizado com sucesso")

      expect(Student.count).to eq(1)

      expect(student.reload.name).to eq("Updated John Doe")
      expect(student.reload.identifier).to eq("54321")
      expect(student.reload.school_class).to eq(second_class)
    end
  end

  describe "Student deletion" do
    it "successfully deletes a Student" do
      create(:student, user:)
      visit students_path
      click_on "Remover"

      expect(page).to have_content("Aluno removido com sucesso")
      expect(Student.count).to eq(0)
    end
  end

  describe "Students List" do
    it "successfully lists all current user's Students" do
      first_student = create(:student, user:, name: "First Student")
      second_student = create(:student, user:, name: "Second Student")

      create(:student, name: "Other User's Student")

      visit students_path

      expect(page).to have_content("First Student")
      expect(page).to have_content("Second Student")

      expect(page).not_to have_content("Other User's Class")

      expect(page).to have_link("Editar", href: edit_student_path(id: first_student.id))

      expect(page).to have_link("Editar", href: edit_student_path(id: second_student.id))

      expect(page).to have_button("Remover", count: 2)

      expect(page).to have_link("Adicionar", href: new_student_path)
    end
  end
end
