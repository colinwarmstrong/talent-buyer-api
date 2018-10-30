require 'rails_helper'

describe 'GET /api/v1/favorite_artists' do
  context 'a buyer going to favorite artists page' do
    it 'will see all artists previously favorited' do
      buyer = Fabricate(:buyer)
      artist_1 = Fabricate(:artist)
      artist_2 = buyer.artists.create(name: 'Boi Jovi', agency: 'Zimbabwe', image_url: 'www.wuh.com', popularity: 7, songkick_id: 7, spotify_url: 'www.wikipedia.org', spotify_id: 7, spotify_followers: 8)
      buyer.favorite_artists.create(artist_id: artist_1.id)
      sign_in buyer

      get '/api/v1/favorite_artists', headers: {'Content-Type': 'application/json'}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      favorite_artists = JSON.parse(response.body, symbolize_names: true)
      first_favorite_artist = favorite_artists.first
      second_favorite_artist = favorite_artists.second

      expect(favorite_artists.length).to eq(2)
      expect(favorite_artists).to be_an(Array)

      expect(first_favorite_artist[:name]).to eq(artist_1.name)
      expect(first_favorite_artist[:agency]).to eq(artist_1.agency)
      expect(first_favorite_artist[:image_url]).to eq(artist_1.image_url)
      expect(first_favorite_artist[:popularity]).to eq(artist_1.popularity)
      expect(first_favorite_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(first_favorite_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(first_favorite_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(first_favorite_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(second_favorite_artist[:name]).to eq(artist_2.name)
      expect(second_favorite_artist[:agency]).to eq(artist_2.agency)
      expect(second_favorite_artist[:image_url]).to eq(artist_2.image_url)
      expect(second_favorite_artist[:popularity]).to eq(artist_2.popularity)
      expect(second_favorite_artist[:songkick_id]).to eq(artist_2.songkick_id)
      expect(second_favorite_artist[:spotify_id]).to eq(artist_2.spotify_id)
      expect(second_favorite_artist[:spotify_url]).to eq(artist_2.spotify_url)
      expect(second_favorite_artist[:spotify_followers]).to eq(artist_2.spotify_followers)
    end
  end
end
