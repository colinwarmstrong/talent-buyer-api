require 'csv'

buyer_1 = Buyer.create(first_name: 'Billy', last_name: 'Mays', email: 'silli@billi.com', password: '123456')
buyer_2 = Buyer.create(first_name: 'Woody', last_name: 'Harrelson', email: 'wo@billi.com', password: '123456')

venue_1 = buyer_1.venues.create(name: 'the ol saloon', street_address: '123 Swan Street', city: 'Uruguay', state: 'Wyoming', zip: 12345, capacity: 4, venue_songkick_id: 2)
venue_2 = buyer_2.venues.create(name: 'the ol spitoon', street_address: '123 Eagle Street', city: 'Paraguay', state: 'Wyoming', zip: 12346, capacity: 2, venue_songkick_id: 3)

show_1 = Show.create(venue_id: venue_1.id, date: Date.parse('2018/10/31'))
show_2 = Show.create(venue_id: venue_1.id, date: Date.parse('2018/11/20'))
show_3 = Show.create(venue_id: venue_2.id, date: Date.parse('2018/10/31'))

artist_1 = Artist.create(name: 'HEYEHEY', agency: 'yes', genres: 'Peruvian Flute', image_url: 'https://i.ytimg.com/vi/hY8m0xXxh3A/maxresdefault.jpg', popularity: 23, songkick_id: 1, spotify_url: 'www.google.com', spotify_id: 1, spotify_followers: 9001)
artist_2 = Artist.create(name: 'Woo!', agency: 'yes', genres: 'Peruvian Trumpet', image_url: 'https://i.ytimg.com/vi/hY8m0xXxh3A/maxresdefault.jpg', popularity: 24, songkick_id: 2, spotify_url: 'www.google.com', spotify_id: 2, spotify_followers: 9002)
artist_3 = Artist.create(name: 'WaHaa!', agency: 'no', genres: 'Peruvian Trombone', image_url: 'https://i.ytimg.com/vi/hY8m0xXxh3A/maxresdefault.jpg', popularity: 27, songkick_id: 3, spotify_url: 'www.google.com', spotify_id: 3, spotify_followers: 9004)

show_1.offers.create(artist_id: artist_1.id, guarantee: 47000, bonuses: 'contentment', radius_clause: 'No shows in 100 mile radius for next 60 days', total_expenses: 63000, gross_potential: 8000, door_times: '9am-5pm', age_range: '60', merch_split: '70-30')
show_1.offers.create(artist_id: artist_2.id, guarantee: 47000, bonuses: 'contentment', radius_clause: 'No shows in 100 mile radius for next 60 days', total_expenses: 63000, gross_potential: 8000, door_times: '9am-5pm', age_range: '60', merch_split: '70-30')
show_2.offers.create(artist_id: artist_2.id, guarantee: 47000, bonuses: 'contentment', radius_clause: 'No shows in 100 mile radius for next 60 days', total_expenses: 63000, gross_potential: 8000, door_times: '9am-5pm', age_range: '60', merch_split: '70-30')
show_3.offers.create(artist_id: artist_3.id, guarantee: 47000, bonuses: 'contentment', radius_clause: 'No shows in 100 mile radius for next 60 days', total_expenses: 63000, gross_potential: 8000, door_times: '9am-5pm', age_range: '60', merch_split: '70-30')

CSV.foreach('./db/data/artists.csv', headers: true, header_converters: :symbol) do |artist|
  Artist.create(
    name:               artist[:name],
    agency:             artist[:agency],
    genres:             artist[:genres],
    image_url:          artist[:image_url],
    popularity:         artist[:popularity],
    songkick_id:        artist[:songkick_id],
    spotify_url:        artist[:spotify_url],
    spotify_id:         artist[:spotify_id],
    spotify_followers:  artist[:spotify_followers]
  )
end
