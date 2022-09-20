class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students, id: :uuid do |t|
      t.string :name, null: false
      t.string :identifier, null: false, unique: true
      t.references :school_class, null: false, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end

    add_index :students, :identifier, unique: true
  end
end
