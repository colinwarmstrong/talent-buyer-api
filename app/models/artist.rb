class Artist < ApplicationRecord
  validates_presence_of :name,
                        :genre,
                        :artist_songkick_id

  has_many :offers
end
