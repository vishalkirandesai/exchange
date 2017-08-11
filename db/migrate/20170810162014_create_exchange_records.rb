# Creates the table ExchangeRecords
class CreateExchangeRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_records do |t|
      t.string :base
      t.date :date

      t.timestamps
    end
  end
end
