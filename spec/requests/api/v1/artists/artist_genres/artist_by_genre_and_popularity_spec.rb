require 'rails_helper'

describe 'Arist Genre Endpoints' do
  context '/api/v1/artists/?genre=:genre' do
    it 'returns all artists by specified genre and popularity' do
      buyer = Fabricate(:buyer)
      sign_in buyer

      artist_1 = Fabricate(:artist, popularity: 100, name: 'Linkin Park')
      artist_2 = Fabricate(:artist, popularity: 97, name: 'Pinkin Park')
      artist_3 = Fabricate(:artist, popularity: 49, name: 'Linkin Lark')
      artist_4 = Fabricate(:artist, popularity: 23, name: 'Pinkin Lark')

      genre_1 = artist_1.genres.create(name: 'rock')
      artist_2.artist_genres.create(genre_id: genre_1.id)
      artist_3.artist_genres.create(genre_id: genre_1.id)

      artist_3.genres.create(name: 'rap')
      artist_4.genres.create(name: 'reggae')

      get '/api/v1/artists?genre=rock&sort=popularity'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists.first
      third_artist = artists.last

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(3)

      expect(first_artist[:name]).to eq(artist_1.name)
      expect(first_artist[:agency]).to eq(artist_1.agency)
      expect(first_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(first_artist[:popularity]).to eq(artist_1.popularity)
      expect(first_artist[:image_url]).to eq(artist_1.image_url)
      expect(first_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(first_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(first_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(third_artist[:name]).to eq(artist_3.name)
      expect(third_artist[:agency]).to eq(artist_3.agency)
      expect(third_artist[:songkick_id]).to eq(artist_3.songkick_id)
      expect(third_artist[:popularity]).to eq(artist_3.popularity)
      expect(third_artist[:image_url]).to eq(artist_3.image_url)
      expect(third_artist[:spotify_id]).to eq(artist_3.spotify_id)
      expect(third_artist[:spotify_url]).to eq(artist_3.spotify_url)
      expect(third_artist[:spotify_followers]).to eq(artist_3.spotify_followers)
    end
    it 'returns all artists by specified genre and spotify_followers' do
      buyer = Fabricate(:buyer)
      sign_in buyer

      artist_1 = Fabricate(:artist, popularity: 100, name: 'Linkin Park')
      artist_2 = Fabricate(:artist, popularity: 97, name: 'Pinkin Park')
      artist_3 = Fabricate(:artist, popularity: 49, name: 'Linkin Lark')
      artist_4 = Fabricate(:artist, popularity: 23, name: 'Pinkin Lark')

      genre_1 = artist_1.genres.create(name: 'rock')
      artist_2.artist_genres.create(genre_id: genre_1.id)
      artist_3.artist_genres.create(genre_id: genre_1.id)

      artist_3.genres.create(name: 'rap')
      artist_4.genres.create(name: 'reggae')

      get '/api/v1/artists?genre=rock&sort=popularity'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists.first
      third_artist = artists.last

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(3)

      expect(first_artist[:name]).to eq(artist_1.name)
      expect(first_artist[:agency]).to eq(artist_1.agency)
      expect(first_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(first_artist[:popularity]).to eq(artist_1.popularity)
      expect(first_artist[:image_url]).to eq(artist_1.image_url)
      expect(first_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(first_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(first_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(third_artist[:name]).to eq(artist_3.name)
      expect(third_artist[:agency]).to eq(artist_3.agency)
      expect(third_artist[:songkick_id]).to eq(artist_3.songkick_id)
      expect(third_artist[:popularity]).to eq(artist_3.popularity)
      expect(third_artist[:image_url]).to eq(artist_3.image_url)
      expect(third_artist[:spotify_id]).to eq(artist_3.spotify_id)
      expect(third_artist[:spotify_url]).to eq(artist_3.spotify_url)
      expect(third_artist[:spotify_followers]).to eq(artist_3.spotify_followers)
    end
  end
end
