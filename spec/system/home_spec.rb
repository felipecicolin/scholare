RSpec.describe "Home" do
  describe "signed in" do
    it do
      user = create(:user)
      sign_in user
      visit root_path

      expect(page).to have_link("Gerenciar Turmas", href: user_school_classes_path(user))
      expect(page).to have_link("Gerenciar Alunos", href: root_path)
      expect(page).to have_link("Gerenciar Provas", href: root_path)

      expect(page).to have_content("Nesta seção você pode gerenciar as turmas em que ministra " \
                                   "aulas, podendo adicionar, editar ou removê-las.")

      expect(page).to have_content("Nesta seção você pode gerenciar os alunos pertencentes a cada " \
                                   "classe, podendo adicionar, editar ou removê-los.")

      expect(page).to have_content("Nesta seção você pode gerenciar as provas que serão aplicadas em " \
                                   "cada classe, podendo adicionar, editar ou removê-las.")
    end

    describe "signed out" do
      it do
        visit root_path

        expect(page).to have_link("Scholare", href: root_path)
        expect(page).to have_link("Comece a usar agora", href: root_path)
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
end
