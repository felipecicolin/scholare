class AddTestToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :test, null: false, foreign_key: true, type: :uuid, index: true
  end
end
