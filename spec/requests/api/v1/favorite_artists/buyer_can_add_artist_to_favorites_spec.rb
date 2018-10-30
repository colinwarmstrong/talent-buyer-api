require 'rails_helper'

describe 'POST /api/v1/favorite_artists' do
  context 'a buyer favoriting an artist' do
    before :each do
      @buyer = Fabricate(:buyer)
      @artist = Fabricate(:artist)
      sign_in @buyer
    end
    it 'will be saved under a buyers favorites' do

      expect(@buyer.favorite_artists.count).to eq(0)

      artist_payload = {
        artist_id: @artist.id
      }

      post '/api/v1/favorite_artists', params: artist_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(@buyer.favorite_artists.count).to eq(1)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_favorite_artist = JSON.parse(response.body, symbolize_names: true)

      expect(new_favorite_artist[:data]).to have_key(:artist_id)
      expect(new_favorite_artist[:data]).to have_key(:buyer_id)
      expect(new_favorite_artist[:data][:buyer_id]).to eq(@buyer.id)
      expect(new_favorite_artist[:data][:artist_id]).to eq(@artist.id)
      expect(new_favorite_artist[:message]).to eq("Added #{@artist.name} to favorites")
    end

    it 'will not be created if artist does not exist' do
      artist_payload = { artist_id: 400 }

      expect(@buyer.favorite_artists.count).to eq(0)

      post '/api/v1/favorite_artists', params: artist_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(@buyer.favorite_artists.count).to eq(0)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      new_artist = JSON.parse(response.body, symbolize_names: true)

      expect(new_artist[:message]).to eq('Artist not found')
    end
  end
end
