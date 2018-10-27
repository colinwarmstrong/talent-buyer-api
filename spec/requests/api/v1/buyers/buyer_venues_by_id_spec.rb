require 'rails_helper'

RSpec.describe 'buyer endpoints' do
  context 'GET /api/v1/buyers/:id/venues' do
    it 'returns all venues associated with a buyer' do
      buyer = Fabricate(:buyer)
      venue = Fabricate(:venue)
      buyer.buyer_venues.create(venue_id: venue.id)
      sign_in buyer

      get "/api/v1/buyers/#{buyer.id}/venues"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      buyer_venues = JSON.parse(response.body, symbolize_names: true)
      buyer_venue = buyer_venues.first

      expect(buyer_venues.length).to eq(1)
      expect(buyer_venue[:name]).to eq(venue.name)
      expect(buyer_venue[:street_address]).to eq(venue.street_address)
      expect(buyer_venue[:city]).to eq(venue.city)
      expect(buyer_venue[:state]).to eq(venue.state)
      expect(buyer_venue[:zip]).to eq(venue.zip)
      expect(buyer_venue[:capacity]).to eq(venue.capacity)
      expect(buyer_venue[:venue_songkick_id]).to eq(venue.venue_songkick_id)
    end
  end
end
