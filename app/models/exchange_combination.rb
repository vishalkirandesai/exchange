# This model stores a combination of waiting period, base, target and date.
class ExchangeCombination < ApplicationRecord
  belongs_to :user

  validates :wait,
            numericality: true,
            allow_nil: false,
            inclusion: { in: 1..25 }
  validates :amount, numericality: { greater_than: 0 }, allow_nil: false
  validates :base, inclusion: { in: Currency::LIST }
  validates :target, inclusion: { in: Currency::LIST }
  validate :currency_validation

  def currency_validation
    return unless base == target
    errors.add(:target, 'currency cannot be the same as the Base currency.')
  end

  def self.find_unique(params, current_user)
    where(user_id: current_user.id,
          base: params['base'],
          target: params['target'],
          wait: params['wait'],
          amount: params['amount']).first
  end

  def self.create_unique(params, current_user)
    exchange_combination = find_unique(params, current_user)
    return exchange_combination if exchange_combination
    exchange_combination =
      new(user_id: current_user.id,
          base: params['base'],
          target: params['target'],
          wait: params['wait'],
          amount: params['amount'])
    exchange_combination
  end
end
