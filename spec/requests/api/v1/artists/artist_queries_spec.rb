require 'rails_helper'

describe 'Arist Endpoints' do
  context '/api/v1/artists' do
    it 'returns all artists' do
      buyer = Fabricate(:buyer)
      sign_in buyer

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
      buyer = Fabricate(:buyer)
      sign_in buyer

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
    it 'returns all artists by popularity' do
      buyer = Fabricate(:buyer)
      sign_in buyer

      artist_1 = Fabricate(:artist, popularity: 100)
      artist_2 = Fabricate(:artist, popularity: 78)
      artist_3 = Fabricate(:artist, popularity: 67)
      artist_4 = Fabricate(:artist, popularity: 4)

      get '/api/v1/artists?sort=popularity'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists.first
      fourth_artist = artists.last

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(4)

      expect(first_artist[:name]).to eq(artist_1.name)
      expect(first_artist[:agency]).to eq(artist_1.agency)
      expect(first_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(first_artist[:popularity]).to eq(artist_1.popularity)
      expect(first_artist[:image_url]).to eq(artist_1.image_url)
      expect(first_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(first_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(first_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(fourth_artist[:name]).to eq(artist_4.name)
      expect(fourth_artist[:agency]).to eq(artist_4.agency)
      expect(fourth_artist[:songkick_id]).to eq(artist_4.songkick_id)
      expect(fourth_artist[:popularity]).to eq(artist_4.popularity)
      expect(fourth_artist[:image_url]).to eq(artist_4.image_url)
      expect(fourth_artist[:spotify_id]).to eq(artist_4.spotify_id)
      expect(fourth_artist[:spotify_url]).to eq(artist_4.spotify_url)
      expect(fourth_artist[:spotify_followers]).to eq(artist_4.spotify_followers)
    end
    it 'returns all artists by agency and genre' do
      buyer = Fabricate(:buyer)
      sign_in buyer

      artist_1 = Fabricate(:artist, agency: 'Hammer Industries')
      artist_2 = Fabricate(:artist, agency: 'Stark Enterprises')
      artist_3 = Fabricate(:artist, agency: 'Hammer Industries')
      artist_4 = Fabricate(:artist, agency: 'Horizon Labs')

      get '/api/v1/artists?sort=popularity'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists.first
      fourth_artist = artists.last

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(4)

      expect(first_artist[:name]).to eq(artist_1.name)
      expect(first_artist[:agency]).to eq(artist_1.agency)
      expect(first_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(first_artist[:popularity]).to eq(artist_1.popularity)
      expect(first_artist[:image_url]).to eq(artist_1.image_url)
      expect(first_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(first_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(first_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(fourth_artist[:name]).to eq(artist_4.name)
      expect(fourth_artist[:agency]).to eq(artist_4.agency)
      expect(fourth_artist[:songkick_id]).to eq(artist_4.songkick_id)
      expect(fourth_artist[:popularity]).to eq(artist_4.popularity)
      expect(fourth_artist[:image_url]).to eq(artist_4.image_url)
      expect(fourth_artist[:spotify_id]).to eq(artist_4.spotify_id)
      expect(fourth_artist[:spotify_url]).to eq(artist_4.spotify_url)
      expect(fourth_artist[:spotify_followers]).to eq(artist_4.spotify_followers)
    end
  end

  context '/api/v1/artists/:id' do
    it 'returns the specified artist' do
      buyer = Fabricate(:buyer)
      sign_in buyer

      artist_1 = Fabricate(:artist)

      get "/api/v1/artists/#{artist_1.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artist = JSON.parse(response.body, symbolize_names: true)

      expect(artist).to be_a(Hash)
      expect(artist[:name]).to eq(artist_1.name)
      expect(artist[:agency]).to eq(artist_1.agency)
      expect(artist[:image_url]).to eq(artist_1.image_url)
      expect(artist[:popularity]).to eq(artist_1.popularity)
      expect(artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(artist[:spotify_followers]).to eq(artist_1.spotify_followers)
    end
  end
end
