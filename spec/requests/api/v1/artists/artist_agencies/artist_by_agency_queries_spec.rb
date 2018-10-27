require 'rails_helper'

describe 'Artist by Agency Queries' do
  context '/api/v1/artists?agency=:agency' do
    before :each do
      buyer = Fabricate(:buyer)
      sign_in buyer
    end

    it 'returns all the artists associated with the specified agency' do
      artist_1 = Fabricate(:artist, name: "Artist 1", agency: 'APM')
      artist_2 = Fabricate(:artist, name: "Artist 2", agency: 'APM')
      artist_3 = Fabricate(:artist, name: "Artist 3", agency: 'Tsunami')
      artist_4 = Fabricate(:artist, name: "Artist 4", agency: 'DDJ')

      get '/api/v1/artists?agency=apm'


      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists.first
      second_artist = artists.last

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(2)

      expect(first_artist[:name]).to eq(artist_1.name)
      expect(first_artist[:agency]).to eq(artist_1.agency)
      expect(first_artist[:image_url]).to eq(artist_1.image_url)
      expect(first_artist[:popularity]).to eq(artist_1.popularity)
      expect(first_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(first_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(first_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(first_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(second_artist[:name]).to eq(artist_2.name)
      expect(second_artist[:agency]).to eq(artist_2.agency)
      expect(second_artist[:image_url]).to eq(artist_2.image_url)
      expect(second_artist[:popularity]).to eq(artist_2.popularity)
      expect(second_artist[:songkick_id]).to eq(artist_2.songkick_id)
      expect(second_artist[:spotify_url]).to eq(artist_2.spotify_url)
      expect(second_artist[:spotify_id]).to eq(artist_2.spotify_id)
      expect(second_artist[:spotify_followers]).to eq(artist_2.spotify_followers)
    end

    it 'returns all the artists associated with the specified agency sorted by popularity' do
      artist_1 = Fabricate(:artist, name: "Artist 1", popularity: 90, agency: 'APM')
      artist_2 = Fabricate(:artist, name: "Artist 2", popularity: 100, agency: 'APM')
      artist_3 = Fabricate(:artist, name: "Artist 3", popularity: 80, agency: 'APM')
      artist_4 = Fabricate(:artist, name: "Artist 4", agency: 'DDJ')

      get '/api/v1/artists?agency=apm&sort=popularity'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists[0]
      second_artist = artists[1]
      third_artist = artists[2]

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(3)

      expect(first_artist[:name]).to eq(artist_2.name)
      expect(first_artist[:agency]).to eq(artist_2.agency)
      expect(first_artist[:image_url]).to eq(artist_2.image_url)
      expect(first_artist[:popularity]).to eq(artist_2.popularity)
      expect(first_artist[:songkick_id]).to eq(artist_2.songkick_id)
      expect(first_artist[:spotify_url]).to eq(artist_2.spotify_url)
      expect(first_artist[:spotify_id]).to eq(artist_2.spotify_id)
      expect(first_artist[:spotify_followers]).to eq(artist_2.spotify_followers)

      expect(second_artist[:name]).to eq(artist_1.name)
      expect(second_artist[:agency]).to eq(artist_1.agency)
      expect(second_artist[:image_url]).to eq(artist_1.image_url)
      expect(second_artist[:popularity]).to eq(artist_1.popularity)
      expect(second_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(second_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(second_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(second_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(third_artist[:name]).to eq(artist_3.name)
      expect(third_artist[:agency]).to eq(artist_3.agency)
      expect(third_artist[:image_url]).to eq(artist_3.image_url)
      expect(third_artist[:popularity]).to eq(artist_3.popularity)
      expect(third_artist[:songkick_id]).to eq(artist_3.songkick_id)
      expect(third_artist[:spotify_url]).to eq(artist_3.spotify_url)
      expect(third_artist[:spotify_id]).to eq(artist_3.spotify_id)
      expect(third_artist[:spotify_followers]).to eq(artist_3.spotify_followers)
    end

    it 'returns all the artists associated with the specified agency sorted by number of followers' do
      artist_1 = Fabricate(:artist, name: "Artist 1", spotify_followers: 90, agency: 'APM')
      artist_2 = Fabricate(:artist, name: "Artist 2", spotify_followers: 100, agency: 'APM')
      artist_3 = Fabricate(:artist, name: "Artist 3", spotify_followers: 80, agency: 'APM')
      artist_4 = Fabricate(:artist, name: "Artist 4", agency: 'DDJ')

      get '/api/v1/artists?agency=apm&sort=followers'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists[0]
      second_artist = artists[1]
      third_artist = artists[2]

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(3)

      expect(first_artist[:name]).to eq(artist_2.name)
      expect(first_artist[:agency]).to eq(artist_2.agency)
      expect(first_artist[:image_url]).to eq(artist_2.image_url)
      expect(first_artist[:popularity]).to eq(artist_2.popularity)
      expect(first_artist[:songkick_id]).to eq(artist_2.songkick_id)
      expect(first_artist[:spotify_url]).to eq(artist_2.spotify_url)
      expect(first_artist[:spotify_id]).to eq(artist_2.spotify_id)
      expect(first_artist[:spotify_followers]).to eq(artist_2.spotify_followers)

      expect(second_artist[:name]).to eq(artist_1.name)
      expect(second_artist[:agency]).to eq(artist_1.agency)
      expect(second_artist[:image_url]).to eq(artist_1.image_url)
      expect(second_artist[:popularity]).to eq(artist_1.popularity)
      expect(second_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(second_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(second_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(second_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(third_artist[:name]).to eq(artist_3.name)
      expect(third_artist[:agency]).to eq(artist_3.agency)
      expect(third_artist[:image_url]).to eq(artist_3.image_url)
      expect(third_artist[:popularity]).to eq(artist_3.popularity)
      expect(third_artist[:songkick_id]).to eq(artist_3.songkick_id)
      expect(third_artist[:spotify_url]).to eq(artist_3.spotify_url)
      expect(third_artist[:spotify_id]).to eq(artist_3.spotify_id)
      expect(third_artist[:spotify_followers]).to eq(artist_3.spotify_followers)
    end

    it 'returns all the artists associated with the specified agency sorted by number of followers' do
      artist_1 = Fabricate(:artist, name: "blink-182", agency: 'APM')
      artist_2 = Fabricate(:artist, name: "ABBA", agency: 'APM')
      artist_3 = Fabricate(:artist, name: "Creed", agency: 'APM')
      artist_4 = Fabricate(:artist, name: "Dr Dre", agency: 'DDJ')

      get '/api/v1/artists?agency=apm&sort=alphabetical'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      artists = JSON.parse(response.body, symbolize_names: true)
      first_artist = artists[0]
      second_artist = artists[1]
      third_artist = artists[2]

      expect(artists).to be_an(Array)
      expect(artists.length).to eq(3)

      expect(first_artist[:name]).to eq(artist_2.name)
      expect(first_artist[:agency]).to eq(artist_2.agency)
      expect(first_artist[:image_url]).to eq(artist_2.image_url)
      expect(first_artist[:popularity]).to eq(artist_2.popularity)
      expect(first_artist[:songkick_id]).to eq(artist_2.songkick_id)
      expect(first_artist[:spotify_url]).to eq(artist_2.spotify_url)
      expect(first_artist[:spotify_id]).to eq(artist_2.spotify_id)
      expect(first_artist[:spotify_followers]).to eq(artist_2.spotify_followers)

      expect(second_artist[:name]).to eq(artist_1.name)
      expect(second_artist[:agency]).to eq(artist_1.agency)
      expect(second_artist[:image_url]).to eq(artist_1.image_url)
      expect(second_artist[:popularity]).to eq(artist_1.popularity)
      expect(second_artist[:songkick_id]).to eq(artist_1.songkick_id)
      expect(second_artist[:spotify_url]).to eq(artist_1.spotify_url)
      expect(second_artist[:spotify_id]).to eq(artist_1.spotify_id)
      expect(second_artist[:spotify_followers]).to eq(artist_1.spotify_followers)

      expect(third_artist[:name]).to eq(artist_3.name)
      expect(third_artist[:agency]).to eq(artist_3.agency)
      expect(third_artist[:image_url]).to eq(artist_3.image_url)
      expect(third_artist[:popularity]).to eq(artist_3.popularity)
      expect(third_artist[:songkick_id]).to eq(artist_3.songkick_id)
      expect(third_artist[:spotify_url]).to eq(artist_3.spotify_url)
      expect(third_artist[:spotify_id]).to eq(artist_3.spotify_id)
      expect(third_artist[:spotify_followers]).to eq(artist_3.spotify_followers)
    end
  end
end
