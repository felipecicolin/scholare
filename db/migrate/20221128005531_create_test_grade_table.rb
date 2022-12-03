class CreateTestGradeTable < ActiveRecord::Migration[7.0]
  def change
    create_table :test_grade, id: :uuid do |t|
      t.references :test, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.integer :grade

      t.timestamps
    end
  end
end
