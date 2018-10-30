require 'rails_helper'

describe 'DELETE /api/v1/favorite_artists' do
  context 'a buyer unfavoriting an artist' do
    it 'will no longer see artist on their favorite artists page' do
      buyer = Fabricate(:buyer)
      artist_1 = Fabricate(:artist)
      artist_2 = buyer.artists.create(name: 'Boi Jovi', agency: 'Zimbabwe', image_url: 'www.wuh.com', popularity: 7, songkick_id: 7, spotify_url: 'www.wikipedia.org', spotify_id: 7, spotify_followers: 8)
      buyer.favorite_artists.create(artist_id: artist_1.id)
      sign_in buyer

      expect(buyer.favorite_artists.count).to eq(2)

      delete "/api/v1/favorite_artists/#{artist_2.id}", headers: {'Content-Type': 'application/json'}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      former_artists = JSON.parse(response.body, symbolize_names: true)

      expect(buyer.favorite_artists.count).to eq(1)
      expect(former_artists[:message]).to eq("#{artist_2.name} removed from favorites")
    end
    it 'will not unfavorite a not yet favorited artist' do
      buyer = Fabricate(:buyer)
      artist_1 = Fabricate(:artist)
      artist_2 = Artist.create(name: 'Boi Jovi', agency: 'Zimbabwe', image_url: 'www.wuh.com', popularity: 7, songkick_id: 7, spotify_url: 'www.wikipedia.org', spotify_id: 7, spotify_followers: 8)
      buyer.favorite_artists.create(artist_id: artist_1.id)
      sign_in buyer

      delete "/api/v1/favorite_artists/#{artist_2.id}", headers: {'Content-Type': 'application/json'}

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      nonexistant_artists = JSON.parse(response.body, symbolize_names: true)

      expect(nonexistant_artists[:message]).to eq("Favorite Artist not found")
    end
  end
end
