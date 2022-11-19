class AddNameToTests < ActiveRecord::Migration[7.0]
  def change
    add_column :tests, :name, :string, null: false

    add_index :tests, [:user_id, :name], unique: true
  end
end
