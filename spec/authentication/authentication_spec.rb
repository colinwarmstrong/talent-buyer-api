require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:buyer) { Fabricate(:buyer) }
  let(:url) { '/login' }
  let(:params) do
    {
      buyer: {
        email: buyer.email,
        password_digest: buyer.password,
        first_name: buyer.first_name,
        last_name: buyer.last_name
      }
    }
  end

  context 'when params are correct' do
    before do
      sign_in buyer
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /logout', type: :request do
  let(:url) { '/logout' }

  it 'returns 204, no content' do
    delete url
    expect(response).to have_http_status(204)
  end
end
