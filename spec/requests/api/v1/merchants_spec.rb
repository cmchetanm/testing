require 'rails_helper'

RSpec.describe Api::V1::MerchantsController do
  let!(:merchants) { create_list(:merchant, 10) }
  let(:merchant_id) { Merchant.first.id }

  describe 'GET #index' do
    before do
      get merchants_path
    end

    it 'returns Merchants' do
      expect(json_response['data']).not_to be_empty
      expect(json_response['data']['merchant'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    before { get merchant_path(merchant_id) }

    context 'when the record exists' do
      it 'returns the merchant' do
        expect(json_response['data']).not_to be_empty
        expect(json_response['data']['merchant']['id']).to eq(merchant_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:merchant_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json_response['errors'][0]['detail']).to eq("Couldn't find Merchant with 'id'=100")
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { name: 'Learn Elm', description: 'lorem', email: "email@email.com"} }

    context 'when the request is valid' do
      before { post merchants_path, params: { merchant: valid_attributes } }

      it 'creates a merchant' do
        expect(json_response['data']['merchant']['name']).to eq('Learn Elm')
        expect(json_response['data']['merchant']['description']).to eq('lorem')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post merchants_path, params: { merchant: { name: 'Foobar'} } }

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
      before { put merchant_path(merchant_id), params: { merchant: valid_attributes } }

      it 'updates the record' do
        expect(json_response['data']['merchant']).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete merchant_path(merchant_id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end
  end
end
