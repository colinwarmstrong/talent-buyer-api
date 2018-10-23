require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let(:params) do
    {
      buyer: {
        email: 'buyer@example.com',
        password: 'password'
      }
    }
  end

  context 'when buyer is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new buyer' do
      expect(response.body).to match_schema('buyer')
    end
  end

  context 'when buyer already exists' do
    before do
      Fabricate :buyer, email: params[:buyer][:email]
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(json['errors'].first['title']).to eq('Bad Request')
    end
  end
end
