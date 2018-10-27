class Genre < ApplicationRecord
  validates_presence_of :name

  has_many :artist_genres
  has_many :artists, through: :artist_genres
end
