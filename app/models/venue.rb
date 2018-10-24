class Venue < ApplicationRecord
  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip,
                        :capacity

  belongs_to :buyer
  has_many :shows
end
