# This model stores the record of exchange rates for a currency on a date.
class ExchangeRecord < ApplicationRecord
  def self.get_historical_data(base, target)
    @history = {}
    current = Date.today
    start = current - 175
    while start < current
      current_record = get_record_from_database(base, current)
      @history[current] = current_record['rates'][target] if current_record
      current -= 7
    end
    @history
  end

  def self.get_record_from_database(base, date)
    where(base: base, date: date.strftime('%Y-%m-%d')).first ||
      fetch_data_from_fixer(base, date)
  end

  def self.fetch_data_from_fixer(base, date)
    url = 'http://api.fixer.io/' + date.strftime('%Y-%m-%d') + '?base=' + base
    record = HTTParty.get url
    if record.code == 200
      new_record = new(record)
      new_record.save
    end
    new_record
  end

  def self.autoregressive_moving_average(data)
    data
  end
end
