# app/jobs/notify_due_expenses_job.rb
class NotifyDueExpensesJob < ApplicationJob
  queue_as :default

  def perform
    users = User.all 

    users.each do |user|
      due_today = user.expenses.where(due_date: Date.today, paid: false)
      if due_today.any?
        ExpenseMailer.with(user:, expenses: due_today).due_today.deliver_later
      end
    end
  end
end
