class BuyerVenue < ApplicationRecord
  belongs_to :buyer
  belongs_to :venue
end
