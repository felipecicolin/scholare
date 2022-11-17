class AddSchoolClassesToTests < ActiveRecord::Migration[7.0]
  def change
    add_reference :tests, :school_class, null: false, type: :uuid, foreign_key: { to_table: :school_classes }
  end
end
