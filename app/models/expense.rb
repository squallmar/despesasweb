class Expense < ApplicationRecord
  belongs_to :user
  
  validates :description, :amount, :date, :category, presence: true
  validates :amount, numericality: { greater_than: 0 }
  
  before_save :set_month_year
  
  CATEGORIES = %w[Alimentação Transporte Moradia Lazer Saúde Educação Outros].freeze

  private
  
  def set_month_year
    self.month = date.month
    self.year = date.year
  end
end