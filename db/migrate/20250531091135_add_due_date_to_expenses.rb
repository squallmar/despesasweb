class AddDueDateToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :due_date, :date
  end
end
