require 'rails_helper'

describe 'Arist Genre Endpoints' do
  context '/api/v1/artists/?genre=:genre?agency=stark industries' do
    it 'returns all artists by specified genre and agency' do
      buyer = Fabricate(:buyer)
      sign_in buyer

      artist_1 = Fabricate(:artist, agency: 'Stark Enterprises')
      artist_2 = Fabricate(:artist, agency: 'Hammer Industries')
      artist_3 = Fabricate(:artist, agency: 'Stark Enterprises')
      artist_4 = Fabricate(:artist, agency: 'Hammer Industries')

      genre_1 = artist_1.genres.create(name: 'rock')
      artist_2.artist_genres.create(genre_id: genre_1.id)
      artist_3.artist_genres.create(genre_id: genre_1.id)

      artist_3.genres.create(name: 'rap')
      artist_4.genres.create(name: 'reggae')

      get '/api/v1/artists?genre=rock&agency=Stark%20Enterprises'

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

      expect(second_artist[:name]).to eq(artist_3.name)
      expect(second_artist[:agency]).to eq(artist_3.agency)
      expect(second_artist[:songkick_id]).to eq(artist_3.songkick_id)
      expect(second_artist[:popularity]).to eq(artist_3.popularity)
      expect(second_artist[:image_url]).to eq(artist_3.image_url)
      expect(second_artist[:spotify_id]).to eq(artist_3.spotify_id)
      expect(second_artist[:spotify_url]).to eq(artist_3.spotify_url)
      expect(second_artist[:spotify_followers]).to eq(artist_3.spotify_followers)
    end
    it 'returns all artists by specified genre and agency ordered by spotify_followers' do
      buyer = Fabricate(:buyer)
      sign_in buyer

      artist_1 = Fabricate(:artist, spotify_followers: 3, agency: 'Stark Enterprises')
      artist_2 = Fabricate(:artist, spotify_followers: 99, agency: 'Hammer Industries')
      artist_3 = Fabricate(:artist, spotify_followers: 2, agency: 'Hammer Industries')
      artist_4 = Fabricate(:artist, spotify_followers: 84, agency: 'Stark Enterprises')

      genre_1 = artist_1.genres.create(name: 'rock')
      artist_2.artist_genres.create(genre_id: genre_1.id)
      artist_3.artist_genres.create(genre_id: genre_1.id)

      genre_2 = artist_3.genres.create(name: 'rap')
      artist_4.artist_genres.create(genre_id: genre_2.id)
      artist_1.artist_genres.create(genre_id: genre_2.id)

      get '/api/v1/artists?genre=rap&agency=Stark%20Enterprises&sort=followers'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists.first
      second_artist = artists.last

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(2)

      expect(first_artist[:name]).to eq(artist_4.name)
      expect(first_artist[:agency]).to eq(artist_4.agency)
      expect(first_artist[:songkick_id]).to eq(artist_4.songkick_id)
      expect(first_artist[:popularity]).to eq(artist_4.popularity)
      expect(first_artist[:image_url]).to eq(artist_4.image_url)
      expect(first_artist[:spotify_id]).to eq(artist_4.spotify_id)
      expect(first_artist[:spotify_url]).to eq(artist_4.spotify_url)
      expect(first_artist[:spotify_followers]).to eq(artist_4.spotify_followers)

      expect(second_artist[:name]).to eq(artist_1.name)
      expect(second_artist[:agency]).to eq(artist_1.agency)
      expect(second_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(second_artist[:popularity]).to eq(artist_1.popularity)
      expect(second_artist[:image_url]).to eq(artist_1.image_url)
      expect(second_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(second_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(second_artist[:spotify_followers]).to eq(artist_1.spotify_followers)
    end
  end
end
