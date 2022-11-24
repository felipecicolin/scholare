class AddOptionToAlternatives < ActiveRecord::Migration[7.0]
  def change
    add_column :alternatives, :option, :string
  end
end
