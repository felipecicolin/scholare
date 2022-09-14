class CreateAlternatives < ActiveRecord::Migration[7.0]
  def change
    create_table :alternatives, id: :uuid do |t|
      t.text :body, null: false
      t.boolean :correct, null: false, default: false
      t.string :option, null: false

      t.references :question, null: false, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
