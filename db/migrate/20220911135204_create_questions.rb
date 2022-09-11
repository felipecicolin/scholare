class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.float :value, null: false
      t.boolean :essay_question, null: false, default: false

      t.timestamps
    end
  end
end
