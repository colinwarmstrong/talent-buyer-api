require 'rails_helper'

RSpec.describe 'GET api/v1/venues/:id' do
  context 'a buyer viewing a venue' do
    before(:each) do
      buyer = Fabricate(:buyer)
      sign_in buyer
    end
    it 'is returned with that specific venue' do
      venue = Fabricate(:venue)
      get "/api/v1/venues/#{venue.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      returned_venue = JSON.parse(response.body, symbolize_names: true)
      
      expect(returned_venue).to have_key(:name)
      expect(returned_venue).to have_key(:street_address)
      expect(returned_venue[:name]).to eq(venue[:name])
      expect(returned_venue[:street_address]).to eq(venue[:street_address])
    end
    it 'does not get a non-existant venue' do
      get "/api/v1/venues/5"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['message']).to eq('Venue does not exist')
    end
  end
end
