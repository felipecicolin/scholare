class RemoveAssociationOfStudentsAndTests < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tests, :student, foreign_key: true, type: :uuid
  end
end
