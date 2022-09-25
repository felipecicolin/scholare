class AddUniqueNameIndexToSchoolClasses < ActiveRecord::Migration[7.0]
  def change
    add_index :school_classes, [:user_id, :name], unique: true
  end
end
