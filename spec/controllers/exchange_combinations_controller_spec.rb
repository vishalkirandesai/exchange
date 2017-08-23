require 'rails_helper'

describe ExchangeCombinationsController do
  login_user
  let(:base) { 'AUD' }
  let(:target) { 'HUF' }
  let(:wait) { '25' }
  let(:amount) { '450' }
  let(:new_amount) { '550' }
  let(:user_id) { 1 }
  let(:another_user_id) { 2 }
  let(:exchange_combination_params) do
    {
      exchange_combination:
        {
          base: base,
          target: target,
          wait: wait,
          amount: amount
        }
    }
  end

  let(:exchange_combination_params_update) do
    {
      base: base,
      target: target,
      wait: wait,
      amount: new_amount
    }
  end

  let(:exchange_combination) { create :exchange_combination, user_id: user_id }

  let(:another_user) { create :user, id: another_user_id }

  let(:exchange_combinations_controller) { ExchangeCombinationsController.new }

  describe '#index' do
    it 'returns all exchanges' do
      expect(ExchangeCombination).to receive(:all).exactly(:once)
      exchange_combinations_controller.index
    end
  end

  describe '#create' do
    it 'searches the records to find existing combination' do
      expect(ExchangeCombination).to receive(:find_unique)
      post :create, params: exchange_combination_params
    end
    it 'creates new record when no records exist' do
      expect(ExchangeCombination).to receive(:new)
      post :create, params: exchange_combination_params
    end
  end

  describe '#show' do
    it 'retrieves historical data' do
      expect(ExchangeRecord).to receive(:get_historical_data)
      get :show, params: { id: exchange_combination.id }
    end
    it 'checks if a record does not exist' do
      expect(ExchangeRecord)
        .to receive(:get_record_from_database).exactly(wait.to_i)
      get :show, params: { id: exchange_combination.id }
    end
    it 'retrieves data from fixer if a record does not exist' do
      expect(ExchangeRecord)
        .to receive(:fetch_data_from_fixer).exactly(wait.to_i)
      get :show, params: { id: exchange_combination.id }
    end
  end

  describe '#update' do
    it 'should need login' do
      expect_any_instance_of(ExchangeCombinationsController)
        .to receive(:current_user?)
      put :update, params: { id: exchange_combination.id, exchange_combination:
                             exchange_combination_params_update }
    end
  end

  describe '#destroy' do
    it 'should need login' do
      expect_any_instance_of(ExchangeCombinationsController)
        .to receive(:current_user?)
      delete :destroy, params: { id: exchange_combination.id,
                                 exchange_combination:
                                 exchange_combination_params_update }
    end
  end
end
