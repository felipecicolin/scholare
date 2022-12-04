class ChangeTestGradeToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :test_grade, :grade, :float
  end
end
