class CreateSchoolClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :school_classes, id: :uuid do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
