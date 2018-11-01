require 'rails_helper'

describe 'POST /api/v1/artists' do
  context 'a buyer creating an artist' do
    before :each do
      buyer = Fabricate(:buyer)
      sign_in buyer
    end

    it 'will be stored in the database' do
      artist_payload = {  name: 'Yung Boi',
                          agency: 'Warner Bros. Entertainment',
                          songkick_id: 100,
                          image_url: 'http://amazon.com',
                          popularity: 78,
                          spotify_id: '101',
                          spotify_url: 'www.example.com',
                          spotify_followers: 101,
                          genres: 'Rock, Reggae'
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
      expect(new_artist[:songkick_id]).to eq(artist_payload[:songkick_id])
      expect(new_artist[:spotify_id]).to eq(artist_payload[:spotify_id])
      expect(new_artist[:image_url]).to eq(artist_payload[:image_url])
      expect(new_artist[:popularity]).to eq(artist_payload[:popularity])
      expect(new_artist[:spotify_followers]).to eq(artist_payload[:spotify_followers])
      expect(new_artist[:spotify_url]).to eq(artist_payload[:spotify_url])
    end

    it 'will only alter an existing artist if songkick_id already in the database' do
      artist = Fabricate(:artist, songkick_id: 100)

      existing_artist_payload = {  name: 'Yung Boi',
                          agency: 'Warner Bros. Entertainment',
                          songkick_id: 100,
                          image_url: 'http://amazon.com',
                          popularity: 78,
                          spotify_id: '101',
                          spotify_url: 'www.example.com',
                          spotify_followers: 101,
                          genres: 'Rock, Reggae'
                        }

      expect(Artist.count).to eq(1)

      post '/api/v1/artists', params: existing_artist_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(Artist.count).to eq(1)
      expect(response).to be_successful
      expect(response.status).to eq(201)

      existing_artist = JSON.parse(response.body, symbolize_names: true)

      expect(existing_artist).to have_key(:id)
      expect(existing_artist[:name]).to eq(existing_artist_payload[:name])
      expect(existing_artist[:agency]).to eq(existing_artist_payload[:agency])
      expect(existing_artist[:songkick_id]).to eq(existing_artist_payload[:songkick_id])
      expect(existing_artist[:spotify_id]).to eq(existing_artist_payload[:spotify_id])
      expect(existing_artist[:image_url]).to eq(existing_artist_payload[:image_url])
      expect(existing_artist[:popularity]).to eq(existing_artist_payload[:popularity])
      expect(existing_artist[:spotify_followers]).to eq(existing_artist_payload[:spotify_followers])
      expect(existing_artist[:spotify_url]).to eq(existing_artist_payload[:spotify_url])
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
    it 'does not create duplicate artist_genres' do
      artist_1 = Fabricate(:artist, name: 'Bad')
      artist_2 = Fabricate(:artist, name: 'Blad')

      genre_1 = artist_1.genres.create(name: 'rock')
      artist_2.artist_genres.create(genre_id: genre_1.id)

      artist_payload = {  name: 'Bad',
                          agency: 'Heavy Metal Boiz',
                          songkick_id: 1234,
                          image_url: 'yowutup',
                          popularity: 12,
                          spotify_id: 'yowutup',
                          spotify_url: 'yowutup',
                          spotify_followers: 12222,
                          genres: 'Rock'
                        }

      expect(ArtistGenre.count).to eq(2)

      post '/api/v1/artists', params: artist_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(ArtistGenre.count).to eq(2)

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end
end
