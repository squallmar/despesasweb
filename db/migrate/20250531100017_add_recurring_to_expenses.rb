class AddRecurringToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :recurring, :boolean
  end
end
