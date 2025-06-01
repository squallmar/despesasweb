class DashboardController < ApplicationController
  def show
    # Dados para o dashboard 
    @total_expenses = Expense.sum(:amount) 
    
    # Despesas por categoria (para um gráfico ou lista)
    #  expense.category guarda o nome da categoria como String
    @expenses_by_category = Expense.group(:category).sum(:amount)

    # Despesas recentes (por exemplo, as 5 últimas)
    @recent_expenses = Expense.order(date: :desc).limit(5)

    # @expenses_last_30_days = Expense.where('date >= ?', 30.days.ago).sum(:amount)
    # @largest_expense = Expense.order(amount: :desc).first
  end
end