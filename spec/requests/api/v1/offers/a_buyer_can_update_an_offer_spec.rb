require 'rails_helper'

describe 'PUT /api/v1/offers/:id' do
  context 'a buyer updating an offer' do
    before(:each) do
      @buyer = Fabricate(:buyer)
      sign_in @buyer
    end
    it 'will be attached to a buyer, artist and venue' do
      venue  = Fabricate(:venue)
      artist = Fabricate(:artist)
      offer  = Fabricate(:offer, venue_id: venue.id, artist_id: artist.id, buyer_id: @buyer.id)

      new_radius_clause = 'Nowhere in the Denver metro area within 40 days'
      new_guarantee = 9002

      updated_offer_params = {
        radius_clause: new_radius_clause,
        guarantee: new_guarantee
      }

      expect(Offer.first.radius_clause).to eq(offer.radius_clause)
      expect(Offer.first.guarantee).to eq(offer.guarantee)

      put "/api/v1/buyers/#{@buyer.id}/offers/#{offer.id}", params: updated_offer_params.to_json, headers: {'Content-Type': 'application/json'}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      edited_offer = JSON.parse(response.body, symbolize_names: true)

      expect(edited_offer[:venue_id]).to eq(offer.venue_id)
      expect(edited_offer[:buyer_id]).to eq(offer.buyer_id)
      expect(edited_offer[:artist_id]).to eq(offer.artist_id)
      expect(edited_offer[:guarantee]).to eq(updated_offer_params[:guarantee])
      expect(edited_offer[:radius_clause]).to eq(updated_offer_params[:radius_clause])
      expect(edited_offer[:bonuses]).to eq(offer.bonuses)
      expect(edited_offer[:total_expenses]).to eq(offer.total_expenses)
      expect(edited_offer[:gross_potential]).to eq(offer.gross_potential)
      expect(edited_offer[:door_times]).to eq(offer.door_times)
      expect(edited_offer[:age_range]).to eq(offer.age_range)
      expect(Date.parse(edited_offer[:date])).to eq(offer.date)
      expect(edited_offer[:merch_split]).to eq(offer.merch_split)
    end

    it 'will not update an offer venue or artist' do
      venue  = Fabricate(:venue)
      artist = Fabricate(:artist)
      offer  = Fabricate(:offer, venue_id: venue.id, artist_id: artist.id, buyer_id: @buyer.id)

      updated_offer_params = {
        venue_id: 2,
        artist_id: 4
      }

      put "/api/v1/buyers/#{@buyer.id}/offers/#{offer.id}", params: updated_offer_params.to_json, headers: {'Content-Type': 'application/json'}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      new_offer = JSON.parse(response.body, symbolize_names: true)

      expect(new_offer[:venue_id]).to eq(offer.venue_id)
      expect(new_offer[:buyer_id]).to eq(offer.buyer_id)
      expect(new_offer[:artist_id]).to eq(offer.artist_id)
      expect(new_offer[:guarantee]).to eq(offer.guarantee)
      expect(new_offer[:radius_clause]).to eq(offer.radius_clause)
      expect(new_offer[:bonuses]).to eq(offer.bonuses)
      expect(new_offer[:total_expenses]).to eq(offer.total_expenses)
      expect(new_offer[:gross_potential]).to eq(offer.gross_potential)
      expect(new_offer[:door_times]).to eq(offer.door_times)
      expect(new_offer[:age_range]).to eq(offer.age_range)
      expect(Date.parse(new_offer[:date])).to eq(offer.date)
      expect(new_offer[:merch_split]).to eq(offer.merch_split)
    end
  end
end
