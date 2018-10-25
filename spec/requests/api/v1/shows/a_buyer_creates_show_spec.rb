require 'rails_helper'

describe 'POST /api/v1/shows' do
  context 'a buyer creating a show' do
    it 'will be stored in the database' do
      venue = Fabricate(:venue)

      show_payload = {  venue_id: venue.id,
                          date: Date.today
                        }

      expect(Show.count).to eq(0)

      post '/api/v1/shows', params: show_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(Show.count).to eq(1)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_show = JSON.parse(response.body, symbolize_names: true)

      expect(new_show[:date]).to eq(show_payload[:date].strftime)
      expect(new_show[:venue_id]).to eq(show_payload[:venue_id])
      expect(new_show[:show_status]).to eq('open')
    end
    it 'will not be created if parameters incorrect' do
      show_payload =  {  venue_id: 40,
                      }

      expect(Show.count).to eq(0)

      post '/api/v1/shows', params: show_payload.to_json, headers: {'Content-Type': 'application/json'}

      expect(Show.count).to eq(0)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      new_show = JSON.parse(response.body, symbolize_names: true)

      expect(new_show[:message]).to eq('Invalid show parameters.')
    end
  end
end
