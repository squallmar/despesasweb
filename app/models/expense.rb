class Expense < ApplicationRecord
  belongs_to :user

  after_create :criar_despesas_recorrentes, if: :recurring?

  validates :description, :amount, :date, :category, presence: true
  validates :amount, numericality: { greater_than: 0 }

  scope :vencendo_hoje, -> { where(due_date: Date.today, paid: false) }

  before_save :set_month_year

  CATEGORIES = %w[Alimentação Transporte Moradia Lazer Saúde Educação Outros].freeze

  private

  def set_month_year
    self.month = date.month
    self.year = date.year
  end

  def criar_despesas_recorrentes
    (1..11).each do |i|
      Expense.create!(
        description: description,
        amount: amount,
        category: category,
        paid: false,
        date: date + i.months,
        due_date: due_date.present? ? due_date + i.months : nil,
        user_id: user_id,
        recurring: false
      )
    end
  end
end
