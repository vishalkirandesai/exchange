# Adds user id to ExchangeCombinations
class AddUserToExchangeCombinations < ActiveRecord::Migration[5.1]
  def change
    add_column :exchange_combinations, :user_id, :integer
  end
end
