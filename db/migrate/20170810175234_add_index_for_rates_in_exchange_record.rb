# Adds index to ExchangeRecords while enabling gin, for faster querying.
class AddIndexForRatesInExchangeRecord < ActiveRecord::Migration[5.1]
  def change
    add_index :exchange_records,
              :rates,
              name: 'exchange_record_rates_idx',
              using: :gin
  end
end
