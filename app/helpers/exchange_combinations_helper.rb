# Helper module for ExchangeCombination
module ExchangeCombinationsHelper
  def min_value(history)
    history.min_by { |k| k[:rate] }[:rate].to_f
  end

  def max_value(history)
    history.max_by { |k| k[:rate] }[:rate].to_f
  end

  def get_best_day(history)
    history.max_by { |k| k[:rate] }[:date]
  end

  def get_arma(history, wait)
    ExchangeRecord.predicted_data(history, wait)
  end

  def get_year(date)
    (Date.parse date).strftime('%Y')
  end

  def determine_profit_or_loss(profit)
    return 'Gain: ' + format('%.2f', profit).to_s unless profit <= 0
    return 'Loss: ' + format('%.2f', -profit).to_s  unless profit.zero?
    'No change'
  end

  def get_week_of_the_year(date)
    (Date.parse date).strftime('%W')
  end

  def rearrange_data_for_chartkick(data)
    result = {}
    data.each do |r|
      result[r[:date]] = r[:rate]
    end
    result
  end
end
