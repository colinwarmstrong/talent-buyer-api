class Artist < ApplicationRecord
  validates_presence_of :name,
                        :agency,
                        :songkick_id,
                        :genres,
                        :image_url,
                        :popularity,
                        :spotify_id,
                        :spotify_url,
                        :spotify_followers

  has_many :offers
end
