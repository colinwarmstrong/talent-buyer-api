require 'rails_helper'

RSpec.describe 'buyer endpoints' do
  context 'GET /api/v1/buyers/:id/venues' do
    it 'returns all venues associated with a buyer' do
      buyer = Fabricate(:buyer)
      venue_1 = Fabricate(:venue)
      venue_2 = Fabricate(:venue, name: 'Fillmmore', venue_songkick_id: 12)

      buyer.buyer_venues.create(venue_id: venue_1.id)
      buyer.buyer_venues.create(venue_id: venue_2.id)

      sign_in buyer

      get "/api/v1/buyers/#{buyer.id}/venues"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      buyer_venues = JSON.parse(response.body, symbolize_names: true)
      buyer_venue_1 = buyer_venues.first
      buyer_venue_2 = buyer_venues.last

      binding.pry

      expect(buyer_venues).to be_an(Array)
      expect(buyer_venues.length).to eq(2)

      expect(buyer_venue_1[:name]).to eq(venue_1.name)
      expect(buyer_venue_1[:street_address]).to eq(venue_1.street_address)
      expect(buyer_venue_1[:city]).to eq(venue_1.city)
      expect(buyer_venue_1[:state]).to eq(venue_1.state)
      expect(buyer_venue_1[:zip]).to eq(venue_1.zip)
      expect(buyer_venue_1[:capacity]).to eq(venue_1.capacity)
      expect(buyer_venue_1[:venue_songkick_id]).to eq(venue_1.venue_songkick_id)

      expect(buyer_venue_2[:name]).to eq(venue_2.name)
      expect(buyer_venue_2[:street_address]).to eq(venue_2.street_address)
      expect(buyer_venue_2[:city]).to eq(venue_2.city)
      expect(buyer_venue_2[:state]).to eq(venue_2.state)
      expect(buyer_venue_2[:zip]).to eq(venue_2.zip)
      expect(buyer_venue_2[:capacity]).to eq(venue_2.capacity)
      expect(buyer_venue_2[:venue_songkick_id]).to eq(venue_2.venue_songkick_id)
    end
  end
end
