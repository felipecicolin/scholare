class AddUserToStudents < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :user, null: false, foreign_key: true, type: :uuid, index: true
  end
end
