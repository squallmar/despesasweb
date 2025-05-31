set :output, "log/cron.log"  # para registrar saída dos comandos

every 1.day, at: '8:00 am' do
  rake "expenses:notify_due"
end
