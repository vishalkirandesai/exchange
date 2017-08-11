require 'rails_helper'

RSpec.describe ExchangeRecord, type: :model do

  let(:valid_params) do
    {
      base: 'AUD',
      date: '2016-07-23'

    }
  end
  it 'is not valid without a base'
  it 'is not valid without a date'
end
