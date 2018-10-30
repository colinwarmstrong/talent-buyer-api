class FavoriteArtist < ApplicationRecord
  belongs_to :buyer
  belongs_to :artist
end
