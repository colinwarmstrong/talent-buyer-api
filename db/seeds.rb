require 'csv'

buyer_1 = Buyer.create!(first_name: 'Billy', last_name: 'Mays', email: 'silli@billi.com', password: '123456')
buyer_2 = Buyer.create!(first_name: 'Woody', last_name: 'Harrelson', email: 'wo@billi.com', password: '123456')

buyer_1.venues.create!(name: 'the ol saloon', street_address: '123 Swan Street', city: 'Uruguay', state: 'Wyoming', zip: 12345, capacity: 4, venue_songkick_id: 2)
buyer_2.venues.create!(name: 'the ol spitoon', street_address: '123 Eagle Street', city: 'Paraguay', state: 'Wyoming', zip: 12346, capacity: 2, venue_songkick_id: 3)

CSV.foreach('./db/data/artists.csv', headers: true, header_converters: :symbol) do |artist|
  new_artist = Artist.create!(
    name:               artist[:name],
    agency:             artist[:agency],
    image_url:          artist[:image_url],
    popularity:         artist[:popularity],
    songkick_id:        artist[:songkick_id],
    spotify_url:        artist[:spotify_url],
    spotify_id:         artist[:spotify_id],
    spotify_followers:  artist[:spotify_followers]
  )
  artist[:genres].split(', ').each do |genre|
    genre = Genre.find_or_create_by(name: genre.downcase)
    ArtistGenre.create!(artist_id: new_artist.id, genre_id: genre.id)
  end
end
