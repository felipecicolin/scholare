class ChangeStudentsNullInTests < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tests, :student_id, true
  end
end
