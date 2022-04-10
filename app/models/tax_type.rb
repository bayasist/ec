class TaxType < ApplicationRecord
  has_many :tax_rates

  def current_tax_rate(current = Date.today)
    tax_rates.find { |rate| rate.begin_at < current && (rate.end_at.blank? || current < rate.end_at) }
  end
end
