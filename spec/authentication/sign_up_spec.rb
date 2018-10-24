require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let(:params) do
    {
      buyer: {
        email: 'buyer@example.com',
        password: 'password',
        first_name: 'Billy',
        last_name: 'Mays'
      }
    }
  end

  context 'when buyer is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      binding.pry
      expect(response.status).to eq 200
    end

    it 'returns a new buyer' do
      new_buyer = JSON.parse(response.body, symbolize_names: true)

      expect(new_buyer[:email]).to eq('buyer@example.com')
      expect(new_buyer[:first_name]).to eq('Billy')
      expect(new_buyer[:last_name]).to eq('Mays')
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
      validation_errors = JSON.parse(response.body, symbolize_names: true)
      expect(validation_errors[:errors].first[:title]).to eq('Bad Request')
    end
  end
end
