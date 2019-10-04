require 'rails_helper'
RSpec.describe Api::V1::Transactions do
  let!(:merchant) { create(:merchant) }
  let!(:transactions) { create_list(:transaction, 10, merchant: merchant) }
  let(:transaction_id) { transactions.first.id }

  describe 'GET #index' do
    before do
      get merchant_transactions_path(merchant.id)
    end

    it 'returns transactions' do
      expect(json_response['data']).not_to be_empty
      expect(json_response['data']['transaction'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    before { get merchant_transaction_path(merchant.id, transaction_id) }

    context 'when the record exists' do
      it 'returns the transaction' do
        expect(json_response['data']).not_to be_empty
        expect(json_response['data']['transaction']['id']).to eq(transaction_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:transaction_id) { 100 }

      it 'returns status code 404' do
        expect(json_response['message']).to eq('ActiveRecord::RecordNotFound')
      end

      it 'returns a not found message' do
        expect(json_response['errors'][0]['detail']).to eq("Couldn't find Transaction with 'id'=100")
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { amount: 12 } }

    context 'when the request is valid' do
      before { post merchant_transactions_path(merchant.id), params: { transaction: valid_attributes } }

      it 'creates a transaction' do
        expect(json_response['data']['transaction']['amount']).to eq('12')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post merchant_transactions_path(merchant.id), params: { transaction: { name: 'Foobar'} } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json_response['success']).to eq(false)
        expect(json_response['errors']).not_to be_empty
      end
    end
  end

  describe 'PUT #update' do

    context 'when the record exists and valid params' do
      let(:valid_attributes) { { name: 'Shopping' } }
      before { put merchant_transaction_path(merchant.id, transaction_id), params: { transaction: valid_attributes } }

      it 'updates the record' do
        expect(json_response['data']['transaction']).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete merchant_transaction_path(merchant.id, transaction_id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end
  end
end
