class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :amount
      t.date :date
      t.string :category
      t.integer :month
      t.integer :year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
