class AddNumberUniqueIndexToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_index :questions, %i[number test_id], unique: true
  end
end
