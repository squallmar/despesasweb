class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy toggle_paid]
  rescue_from ActiveRecord::RecordNotFound, with: :expense_not_found

  def index
    @selected_month = params[:month] || Date.current.month
    @selected_year = params[:year] || Date.current.year

    @expenses = current_user.expenses
                             .where(month: @selected_month, year: @selected_year)
                             .order(date: :desc)

    if params[:category].present?
      @expenses = @expenses.where(category: params[:category])
    end

    if params[:paid].present?
      @expenses = @expenses.where(paid: params[:paid] == "true")
    end

    if params[:min_value].present?
      @expenses = @expenses.where("amount >= ?", params[:min_value].to_f)
    end

    if params[:max_value].present?
      @expenses = @expenses.where("amount <= ?", params[:max_value].to_f)
    end

    @due_today = @expenses.where(due_date: Date.today, paid: false)
    flash.now[:alert] = "Você tem #{@due_today.count} despesa(s) vencendo hoje!" if @due_today.any?
  end

  def toggle_paid
    @expense.update(paid: !@expense.paid)
    redirect_to expenses_path
  end

  def report
    @expenses = Expense.where(user: current_user)

    pdf = Prawn::Document.new

    pdf.text "Relatório de Despesas", size: 20, style: :bold
    pdf.move_down 20

    table_data = [["Descrição", "Valor", "Data", "Categoria", "Pago?"]]
    @expenses.each do |expense|
      table_data << [
        expense.description,
        "R$ #{'%.2f' % expense.amount}",
        expense.date.strftime("%d/%m/%Y"),
        expense.category,
        expense.paid? ? "Sim" : "Não"
      ]
    end

    pdf.table(table_data, header: true, row_colors: ["F0F0F0", "FFFFFF"])

    send_data pdf.render, filename: "relatorio_despesas.pdf", type: "application/pdf"
  end

  def clear_all
    current_user.expenses.destroy_all
    redirect_to expenses_path, notice: "Todas as despesas foram excluídas com sucesso."
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

  def destroy_all_recurrences
    expense = Expense.find(params[:id])
    Expense.where(recurring_group: expense.recurring_group).destroy_all
    redirect_to expenses_path, notice: "Todas as despesas recorrentes foram excluídas com sucesso."
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
    @expense = Expense.find(params[:id])

    if @expense.recurring? && Expense.where(recurring_group: @expense.recurring_group).where("date > ?", @expense.date).exists?
      # Redireciona para a view de confirmação personalizada
      redirect_to confirm_destroy_expense_path(@expense)
    else
      @expense.destroy
      redirect_to expenses_path, notice: "Despesa excluída com sucesso."
    end
  end

  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_not_found
    redirect_to expenses_url, alert: "Despesa não encontrada ou não autorizada."
  end

  def expense_params
    params.require(:expense).permit(
      :description, :amount, :date, :category,
      :paid, :month, :year, :due_date, :recurring
    )
  end


end
