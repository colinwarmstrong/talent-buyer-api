require 'rails_helper'

RSpec.describe 'buyer endpoints' do
  context 'GET /api/v1/buyers/:id/venues' do
    it 'returns all venues associated with a buyer' do
      buyer = Fabricate(:buyer)
      artist = Fabricate(:artist)
      venue = Fabricate(:venue)
      sign_in buyer

      offer_1 = Fabricate(:offer, artist_id: artist.id, venue_id: venue.id, buyer_id: buyer.id)
      offer_2 = Fabricate(:offer, artist_id: artist.id, venue_id: venue.id, buyer_id: buyer.id)

      get "/api/v1/buyers/#{buyer.id}/offers"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      buyer_offers = JSON.parse(response.body, symbolize_names: true)
      first_buyer_offer = buyer_offers.first
      second_buyer_offer = buyer_offers.last

      expect(buyer_offers).to be_an(Array)
      expect(buyer_offers.length).to eq(2)

      expect(first_buyer_offer[:status]).to eq(offer_1.status)
      expect(first_buyer_offer[:guarantee]).to eq(offer_1.guarantee)
      expect(Date.parse(first_buyer_offer[:date])).to eq(offer_1.date)
      expect(first_buyer_offer[:bonuses]).to eq(offer_1.bonuses)
      expect(first_buyer_offer[:radius_clause]).to eq(offer_1.radius_clause)
      expect(first_buyer_offer[:total_expenses]).to eq(offer_1.total_expenses)
      expect(first_buyer_offer[:gross_potential]).to eq(offer_1.gross_potential)
      expect(first_buyer_offer[:door_times]).to eq(offer_1.door_times)
      expect(first_buyer_offer[:age_range]).to eq(offer_1.age_range)
      expect(first_buyer_offer[:merch_split]).to eq(offer_1.merch_split)
      expect(first_buyer_offer[:artist_name]).to eq(offer_1.artist_name)

      expect(second_buyer_offer[:status]).to eq(offer_2.status)
      expect(second_buyer_offer[:guarantee]).to eq(offer_2.guarantee)
      expect(Date.parse(second_buyer_offer[:date])).to eq(offer_2.date)
      expect(second_buyer_offer[:bonuses]).to eq(offer_2.bonuses)
      expect(second_buyer_offer[:radius_clause]).to eq(offer_2.radius_clause)
      expect(second_buyer_offer[:total_expenses]).to eq(offer_2.total_expenses)
      expect(second_buyer_offer[:gross_potential]).to eq(offer_2.gross_potential)
      expect(second_buyer_offer[:door_times]).to eq(offer_2.door_times)
      expect(second_buyer_offer[:age_range]).to eq(offer_2.age_range)
      expect(second_buyer_offer[:merch_split]).to eq(offer_2.merch_split)
      expect(second_buyer_offer[:artist_name]).to eq(offer_2.artist_name)
    end
  end
end
