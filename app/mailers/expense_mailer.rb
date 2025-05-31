# app/mailers/expense_mailer.rb
class ExpenseMailer < ApplicationMailer
  default from: 'marcelmendes05@gmail.com' 

  def vencendo_notification(expense)
    @expense = expense
    mail(
      to: 'marcelmendes05@gmail.com', 
      subject: "Despesa vencendo hoje: #{@expense.description}"
    )
  end
end
