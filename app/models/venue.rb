class Venue < ApplicationRecord
  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip,
                        :capacity,
                        :venue_songkick_id

  validates_uniqueness_of :venue_songkick_id

  has_many :offers
  has_many :buyer_venues
  has_many :buyers, through: :buyer_venues
end
