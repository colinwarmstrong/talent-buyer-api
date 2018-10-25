require 'rails_helper'

RSpec.describe 'GET api/v1/venues/:id' do
  context 'a buyer viewing a venue' do
    it 'is returned with that specific venue' do
      venue = Fabricate(:venue)
      get "/api/v1/venues/#{venue.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      got_venue = JSON.parse(response.body, symbolize_names: true)

      expect(got_venue).to have_key(:name)
      expect(got_venue).to have_key(:street_address)
      expect(got_venue[:name]).to eq(venue[:name])
      expect(got_venue[:street_address]).to eq(venue[:street_address])
    end
    it 'does not get a non-existant venue' do
      get "/api/v1/venues/5"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['message']).to eq('Venue does not exist')
    end
  end
end
