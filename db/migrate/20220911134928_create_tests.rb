class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests, id: :uuid do |t|
      t.string :subject, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
