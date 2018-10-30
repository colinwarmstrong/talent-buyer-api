require 'rails_helper'

describe ArtistGenreLinker do
  context 'class methods' do
    it '#link - links genres from params to an artist' do
      artist = Fabricate(:artist, popularity: 100, name: 'Linkin Park')
      genres = "Rock, Rap-Rock, Claire's favorite band"

      expect{ArtistGenreLinker.link(artist, genres)}.to change{ArtistGenre.count}.by(3)
      expect(artist.genres.count).to eq(3)
    end

    it '#link - will not create new genres if they all ready exist' do
      artist = Fabricate(:artist, popularity: 100, name: 'Linkin Park')
      cool_genre = Genre.create!(name: "claire's favorite band")
      genres = "Rock, Rap-Rock, Claire's favorite band"

      expect{ArtistGenreLinker.link(artist, genres)}.to change{Genre.count}.by(2)
      expect(artist.genres.count).to eq(3)
    end
  end
end