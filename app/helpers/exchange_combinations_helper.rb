# Helper module for ExchangeCombination
module ExchangeCombinationsHelper
  def min_value(history)
    history.values.min
  end

  def max_value(history)
    history.values.max
  end

  def get_best_day(history)
    history.key(max_value(history))
  end

  def get_arma(history, wait)
    ExchangeRecord.predicted_data(history, wait)
  end
end
