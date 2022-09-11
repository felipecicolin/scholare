class AddUserToTests < ActiveRecord::Migration[7.0]
  def change
    add_reference :tests, :user, null: false, foreign_key: true, type: :uuid, index: true
  end
end
