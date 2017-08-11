# Helper module for ExchangeCombination
module ExchangeCombinationsHelper
  def min_value(history)
    history.values.min
  end

  def max_value(history)
    history.values.max
  end

  def get_arma(history)
    ExchangeRecord.autoregressive_moving_average(history)
  end
end
