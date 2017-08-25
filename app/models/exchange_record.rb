# This model stores the record of exchange rates for a currency on a date.
class ExchangeRecord < ApplicationRecord
  validates :base, inclusion: { in: Currency::LIST }
  validates :date, presence: true
  def self.get_historical_data(base, target)
    @history = []
    ((Date.today - 25.weeks)..Date.today).step(7) do |current|
      current_record = get_record_from_database(base, current)
      if current_record
        @history << { date: current, rate: current_record['rates'][target] }
      end
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

  def self.predicted_data(history, wait)
    price = history.last[:rate].to_f
    average = calculate_average(history)
    calculate_predicted_data(history.last[:date], wait, price, average)
  end

  def self.calculate_average(history)
    (history.first[:rate].to_f - history.last[:rate].to_f) /
      history.size.to_f
  end

  def self.calculate_predicted_data(start, wait, price, average)
    predicted = []
    original_price = price
    (start..(start + (7 * wait))).step(7) do |date|
      predicted << { date: date.strftime('%Y-%m-%d'),
                     profit: price - original_price,
                     rate: price }
      price -= average
    end
    get_ranking(predicted)
  end

  def self.get_ranking(predictions)
    ascending = predictions.sort { |a, b| a[:rate] <=> b[:rate] }.uniq.reverse
    predictions.each do |p|
      p[:rank] = ascending.index(p) + 1
    end
  end
end
