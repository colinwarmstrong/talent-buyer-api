require 'rails_helper'

describe 'Arist Endpoints' do
  context '/api/v1/artists' do
    before :each do
      buyer = Fabricate(:buyer)
      sign_in buyer
    end
    
    it 'returns all artists' do
      artist_1 = Fabricate(:artist, name: 'Beastie Bois')
      artist_2 = Fabricate(:artist, name: 'Beach Bois')
      artist_3 = Fabricate(:artist, name: 'New Bois')
      artist_4 = Fabricate(:artist, name: 'Franchise Bois')

      get '/api/v1/artists'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      artist = artists.first

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(4)

      expect(artist[:name]).to eq(artist_1.name)
      expect(artist[:agency]).to eq(artist_1.agency)
      expect(artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(artist[:popularity]).to eq(artist_1.popularity)
      expect(artist[:image_url]).to eq(artist_1.image_url)
      expect(artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(artist[:spotify_followers]).to eq(artist_1.spotify_followers)
    end
  end

  context '/api/v1/artists/?genre=:genre' do
    it 'returns all artists by specified genre' do
      artist_1 = Fabricate(:artist, name: 'Beastie Bois')
      artist_2 = Fabricate(:artist, name: 'Beach Bois')
      artist_3 = Fabricate(:artist, name: 'New Bois')
      artist_4 = Fabricate(:artist, name: 'Franchise Bois')

      genre_1 = artist_1.genres.create(name: 'rock')
      artist_2.artist_genres.create(genre_id: genre_1.id)

      artist_3.genres.create(name: 'rap')
      artist_4.genres.create(name: 'reggae')

      get '/api/v1/artists?genre=rock'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists.first
      second_artist = artists.last

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(2)

      expect(first_artist[:name]).to eq(artist_1.name)
      expect(first_artist[:agency]).to eq(artist_1.agency)
      expect(first_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(first_artist[:popularity]).to eq(artist_1.popularity)
      expect(first_artist[:image_url]).to eq(artist_1.image_url)
      expect(first_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(first_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(first_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(second_artist[:name]).to eq(artist_2.name)
      expect(second_artist[:agency]).to eq(artist_2.agency)
      expect(second_artist[:songkick_id]).to eq(artist_2.songkick_id)
      expect(second_artist[:popularity]).to eq(artist_2.popularity)
      expect(second_artist[:image_url]).to eq(artist_2.image_url)
      expect(second_artist[:spotify_id]).to eq(artist_2.spotify_id)
      expect(second_artist[:spotify_url]).to eq(artist_2.spotify_url)
      expect(second_artist[:spotify_followers]).to eq(artist_2.spotify_followers)
    end
  end
end
