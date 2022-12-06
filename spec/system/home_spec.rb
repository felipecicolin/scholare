RSpec.describe "Home" do
  describe "signed in" do
    it do
      user = create(:user)
      sign_in user
      visit root_path

      expect(page).to have_link("Gerenciar Turmas", href: school_classes_path)
      expect(page).to have_link("Gerenciar Alunos", href: students_path)
      expect(page).to have_link("Gerenciar Provas", href: tests_path)

      expect(page).to have_content("Nesta seção você pode gerenciar as turmas em que ministra aulas")

      expect(page).to have_content("Nesta seção você pode gerenciar os alunos pertencentes a cada turma")

      expect(page).to have_content("Nesta seção você pode gerenciar as provas que serão aplicadas em cada turma")
    end
  end

  describe "signed out" do
    it do
      visit root_path

      expect(page).to have_link("Scholare", href: root_path)
      expect(page).to have_link("Comece a usar agora", href: new_user_session_path)
      expect(page).to have_link("Saiba mais", href: root_path)

      expect(page).to have_content("Não quer mais passar horas criando e corrigindo provas?")
      expect(page).to have_content("Aqui no Scholare você pode criar provas e corrigi-las de " \
                                   "forma rápida e fácil, além de poder organizar seus alunos e turmas.")

      expect(page).not_to have_content("Gerenciar Turmas")
      expect(page).not_to have_content("Gerenciar Alunos")
      expect(page).not_to have_content("Gerenciar Provas")
    end
  end
end
