class ChangeTestGradeToTestGrades < ActiveRecord::Migration[7.0]
  def change
    rename_table :test_grade, :test_grades
  end
end
