class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @selected_month = params[:month] || Date.current.month
    @selected_year = params[:year] || Date.current.year
    
    @expenses = current_user.expenses
                      .where(month: @selected_month, year: @selected_year)
                      .order(date: :desc)
  end

  def show
  end

  def new
    @expense = current_user.expenses.build(date: Date.current)
  end

  def edit
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_url, notice: "Despesa criada com sucesso." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_url, notice: "Despesa atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Despesa removida com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = current_user.expenses.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:description, :amount, :date, :category)
    end
end