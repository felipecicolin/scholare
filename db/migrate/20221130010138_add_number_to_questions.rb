class AddNumberToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :number, :integer, null: false
  end
end
