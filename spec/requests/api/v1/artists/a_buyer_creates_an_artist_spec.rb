require 'rails_helper'

describe 'POST /api/v1/artists' do
  context 'a buyer creating an artist' do
    it 'will be stored in the database' do
      artist_payload = {  name: 'Yung Boi',
                          agency: 'Warner Bros. Entertainment',
                          genres: 'Metal Incrementally',
                          songkick_id: 100,
                          image_url: 'http://amazon.com',
                          popularity: 78,
                          spotify_id: '101',
                          spotify_url: 'www.example.com',
                          spotify_followers: 101
                        }

      expect(Artist.count).to eq(0)

      post '/api/v1/artists', params: artist_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(Artist.count).to eq(1)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_artist = JSON.parse(response.body, symbolize_names: true)

      expect(new_artist).to have_key(:id)
      expect(new_artist[:name]).to eq(artist_payload[:name])
      expect(new_artist[:agency]).to eq(artist_payload[:agency])
      expect(new_artist[:artist_songkick_id]).to eq(artist_payload[:artist_songkick_id])
      expect(new_artist[:artist_spotify_id]).to eq(artist_payload[:artist_spotify_id])
    end
    it 'will not be created if parameters incorrect' do
      artist_payload = {  name: 'Yung Boi',
                          agency: 'Whup'
                        }

      expect(Artist.count).to eq(0)

      post '/api/v1/artists', params: artist_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(Artist.count).to eq(0)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      new_artist = JSON.parse(response.body, symbolize_names: true)

      expect(new_artist[:message]).to eq('Invalid artist parameters.')
    end
  end
end
