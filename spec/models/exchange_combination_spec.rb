require 'rails_helper'

RSpec.describe ExchangeCombination, type: :model do
  let(:another_user) { create :user, id: 2 }
  let(:valid_params) do
    {
      user_id: 2,
      base: 'AUD',
      target: 'EUR',
      amount: '450',
      wait: '14'
    }
  end
  let(:invalid_params_without_target) do
    {
      base: 'AUD',
      amount: '450',
      wait: '14'
    }
  end
  let(:invalid_params_without_wait) do
    {
      base: 'AUD',
      target: 'EUR',
      amount: '450'
    }
  end
  let(:invalid_params_without_amount) do
    {
      base: 'AUD',
      target: 'EUR',
      wait: '14'
    }
  end
  let(:invalid_params_with_base_equal_to_target) do
    {
      base: 'AUD',
      target: 'AUD',
      amount: '450',
      wait: '14'
    }
  end
  let(:invalid_params_without_base) do
    {
      target: 'EUR',
      amount: '450',
      wait: '14'
    }
  end
  let(:invalid_params_with_negative_amount) do
    {
      base: 'AUD',
      target: 'EUR',
      amount: '-450',
      wait: '14'
    }
  end
  let(:invalid_params_with_wait_less_than_one) do
    {
      base: 'AUD',
      target: 'EUR',
      amount: '450',
      wait: '0'
    }
  end
  let(:invalid_params_with_wait_more_than_twenty_five) do
    {
      base: 'AUD',
      target: 'EUR',
      amount: '-450',
      wait: '28'
    }
  end
  it 'is valid with valid combinations' do
    exchange_record = another_user.exchange_combinations.build(
      valid_params
    )
    expect(exchange_record).to be_valid
  end
  it 'is not valid without an amount' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_without_amount
    )
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid without a base' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_without_base
    )
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid without a target' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_without_target
    )
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid without a wait' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_without_wait
    )
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid with a negative amount' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_with_negative_amount
    )
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid with base equal to target' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_with_base_equal_to_target
    )
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid with wait less than 1' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_with_wait_less_than_one
    )
    expect(exchange_record).to_not be_valid
  end
  it 'is not valid with wait more than 25' do
    exchange_record = another_user.exchange_combinations.build(
      invalid_params_with_wait_more_than_twenty_five
    )
    expect(exchange_record).to_not be_valid
  end
end
