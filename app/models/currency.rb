# This model stores a list of all accepted currencies.
class Currency < ApplicationRecord
  LIST = %w(AUD BGN BRL CAD CHF CNY CZK DKK EUR GBP HKD HRK HUF IDR ILS INR)
         .freeze
end
