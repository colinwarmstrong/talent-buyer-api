class Venue < ApplicationRecord
  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip,
                        :capacity

  has_many :buyer_venues
  has_many :buyers, through: :buyer_venues
  has_many :shows
end
