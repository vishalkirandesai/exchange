# Creates the table ExchangeCombinations
class CreateExchangeCombinations < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_combinations do |t|
      t.string :base
      t.string :target
      t.integer :amount
      t.integer :wait

      t.timestamps
    end
  end
end
