class RemoveEssayQuestionFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :essay_question, :boolean
  end
end
