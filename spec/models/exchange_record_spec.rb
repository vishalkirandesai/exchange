require 'rails_helper'

RSpec.describe ExchangeRecord, type: :model do
  let(:valid_params) do
    {
      base: 'AUD',
      date: '2016-07-23'
    }
  end
  let(:invalid_params) do
    {
      base: 'AUD'
    }
  end
  let(:invalid_params_without_base) do
    {
      date: '2016-07-23'
    }
  end
  it 'is valid without a base and date' do
    exchange_record = ExchangeRecord.new(valid_params)
    expect(exchange_record).to be_valid
  end
  it 'is not valid without a date' do
    exchange_record = ExchangeRecord.new(invalid_params)
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid without a base' do
    exchange_record = ExchangeRecord.new(invalid_params_without_base)
    expect(exchange_record).to_not be_valid
  end
end
