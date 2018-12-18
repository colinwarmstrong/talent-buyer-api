class Artist < ApplicationRecord
  validates_presence_of :name,
                        :agency,
                        :songkick_id,
                        :image_url,
                        :popularity,
                        :spotify_id,
                        :spotify_url,
                        :spotify_followers

  has_many :offers
  has_many :artist_genres
  has_many :favorite_artists
  has_many :genres, through: :artist_genres
  has_many :buyers, through: :favorite_artists
end
