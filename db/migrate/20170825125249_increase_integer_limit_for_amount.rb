# migration to increase limit for amount integer
class IncreaseIntegerLimitForAmount < ActiveRecord::Migration[5.1]
  def change
    change_column :exchange_combinations, :amount, :integer, limit: 8
  end
end
