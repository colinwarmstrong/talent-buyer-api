require 'rails_helper'

describe 'POST /api/v1/offers' do
  context 'a buyer creating an offer' do
    before(:each) do
      @buyer = Fabricate(:buyer)
      sign_in @buyer
    end
    it 'will be attached to a buyer, artist and venue' do
      venue  = Fabricate(:venue)
      artist = Fabricate(:artist)

      offer_payload = { venue_id: venue.id,
                        artist_id: artist.id,
                        buyer_id: @buyer.id,
                        guarantee: 10000,
                        bonuses: 'No bonuses',
                        radius_clause: 'No shows within 100 miles ever',
                        total_expenses: 12000,
                        gross_potential: 15000,
                        door_times: '9pm-12pm',
                        age_range: 'Over 21',
                        merch_split: '90-10',
                        date: '1993-11-23'
                      }

      expect(Offer.count).to eq(0)

      post '/api/v1/offers', params: offer_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(Offer.count).to eq(1)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_offer = JSON.parse(response.body, symbolize_names: true)

      expect(new_offer).to have_key(:id)
      expect(new_offer[:venue_id]).to eq(offer_payload[:venue_id])
      expect(new_offer[:buyer_id]).to eq(offer_payload[:buyer_id])
      expect(new_offer[:artist_id]).to eq(offer_payload[:artist_id])
      expect(new_offer[:guarantee]).to eq(offer_payload[:guarantee])
      expect(new_offer[:bonuses]).to eq(offer_payload[:bonuses])
      expect(new_offer[:radius_clause]).to eq(offer_payload[:radius_clause])
      expect(new_offer[:total_expenses]).to eq(offer_payload[:total_expenses])
      expect(new_offer[:gross_potential]).to eq(offer_payload[:gross_potential])
      expect(new_offer[:door_times]).to eq(offer_payload[:door_times])
      expect(new_offer[:age_range]).to eq(offer_payload[:age_range])
      expect(new_offer[:date]).to eq(offer_payload[:date])
      expect(new_offer[:merch_split]).to eq(offer_payload[:merch_split])
    end

    it 'will not create an offer if given invalid parameters' do
      artist = Fabricate(:artist)

      offer_payload = { artist_id: artist.id,
                        guarantee: 10000,
                        bonuses: 'No bonuses',
                        radius_clause: 'No shows within 100 miles ever',
                        total_expenses: 12000,
                        gross_potential: 15000,
                        door_times: '9pm-12pm',
                        age_range: 'Over 21'
                      }

      expect(Offer.count).to eq(0)

      post '/api/v1/offers', params: offer_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(Offer.count).to eq(0)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      invalid_response = JSON.parse(response.body, symbolize_names: true)

      expect(invalid_response[:message]).to eq('Invalid offer parameters.')
    end
  end
end
