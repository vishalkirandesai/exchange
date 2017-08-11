# Adds rates hash to ExchangeRecord
class AddRatesToExchangeRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :exchange_records, :rates, :hstore, default: {}, null: false
  end
end
