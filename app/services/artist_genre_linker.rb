class ArtistGenreLinker
  def self.link(artist, genres)
    genre_list = genres.split(', ')
    genre_list.each do | genre |
      stored_genre = Genre.find_or_create_by(name: genre.downcase)
      ArtistGenre.where(artist_id: artist.id).find_or_create_by(genre_id: stored_genre.id)
    end
  end
end
