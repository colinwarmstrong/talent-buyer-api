 require 'rails_helper'

RSpec.describe 'POST api/v1/venues' do
  context 'a buyer making an account' do
    before(:each) do
      buyer = Fabricate(:buyer)
      sign_in buyer
    end
    it 'is created with a venue' do
      venue_body = { name: 'Weezy',
                     street_address: '1234 Swan Street',
                     city: 'A-Town',
                     state: 'Confusion',
                     zip: '12345',
                     capacity: 23,
                     venue_songkick_id: 98
                    }

      post "/api/v1/venues", params: venue_body.to_json, headers: {'Content-Type': 'application/json'}
      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_venue = JSON.parse(response.body, symbolize_names: true)

      expect(new_venue).to have_key(:name)
      expect(new_venue).to have_key(:street_address)
      expect(new_venue[:name]).to eq(venue_body[:name])
      expect(new_venue[:street_address]).to eq(venue_body[:street_address])
    end
    it 'does not make a venue without all proper parameters' do
      venue_body = { name: 'Weezy',
                     street_address: '1234 Swan Street',
                     city: 'A-Town',
                     state: 'Confusion',
                     zip: '12345'
                   }

      post "/api/v1/venues", params: venue_body.to_json, headers: {'Content-Type': 'application/json'}
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['message']).to eq('Invalid venue parameters')
    end
    it 'cannot create a duplicate venue' do
      venue_body = { name: 'Weezy',
        street_address: '1234 Swan Street',
        city: 'A-Town',
        state: 'Confusion',
        zip: '12345',
        capacity: '23',
        venue_songkick_id: 98
      }

      Venue.create(venue_body)

      expect(Venue.count).to eq(1)

      post "/api/v1/venues", params: venue_body.to_json, headers: {'Content-Type': 'application/json'}

      expect(Venue.count).to eq(1)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:message]).to eq('Invalid venue parameters')
    end
  end
end
