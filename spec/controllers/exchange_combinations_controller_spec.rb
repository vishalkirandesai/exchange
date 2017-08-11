require 'rails_helper'

describe ExchangeCombinationsController do
  login_user
  let(:exchange_combination_params) do
    {
      exchange_combination:
        {
          base: 'AUD',
          target: 'HUF',
          wait: '25',
          amount: '450'
        }
    }
  end

  let(:exchange_combination_params_update) do
    {
      base: 'AUD',
      target: 'HUF',
      wait: '25',
      amount: '550'
    }
  end

  let(:exchange_combination) { create :exchange_combination, user_id: 1 }

  let(:another_user) { create :user, id: 2 }

  let(:exchange_combinations_controller) { ExchangeCombinationsController.new }

  describe '#index' do
    it 'returns all exchanges' do
      expect(ExchangeCombination).to receive(:all).exactly(:once)
      exchange_combinations_controller.index
    end
  end

  describe '#create' do
    it 'saves after create' do
      expect_any_instance_of(ExchangeCombination).to receive(:save)
      post :create, params: exchange_combination_params
    end
  end

  describe '#show' do
    it 'retrieves historical data' do
      expect(ExchangeRecord).to receive(:get_historical_data)
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
