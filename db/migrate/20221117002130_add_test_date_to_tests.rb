class AddTestDateToTests < ActiveRecord::Migration[7.0]
  def change
    add_column :tests, :test_date, :date, null: false
  end
end
