class AddPaidToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :paid, :boolean
  end
end
