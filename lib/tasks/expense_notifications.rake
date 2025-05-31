# lib/tasks/expense_notifications.rake
namespace :expenses do
  desc "Enviar e-mail para despesas vencendo hoje"
  task notify_due: :environment do
    Expense.vencendo_hoje.each do |expense|
      ExpenseMailer.vencendo_notification(expense).deliver_now
      puts "Notificação enviada para: #{expense.user.email}"
    end
  end
end
