class RemoveOptionFromAlternatives < ActiveRecord::Migration[7.0]
  def change
    remove_column :alternatives, :option, :string
  end
end
