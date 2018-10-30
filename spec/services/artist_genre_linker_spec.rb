require 'rails_helper'

describe ArtistGenreLinker do
  context 'class methods' do
    it '#link - links genres from params to an artist' do
      artist = Fabricate(:artist, popularity: 100, name: 'Linkin Park')
      genres = "Rock, Rap-Rock, Claire's favorite band"

      expect{ArtistGenreLinker.link(artist, genres)}.to change{ArtistGenre.count}.by(3)
      expect(artist.genres.count).to eq(3)
    end

    # it '#link - will not '
  end
end