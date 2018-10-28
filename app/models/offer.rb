class Offer < ApplicationRecord
  validates_presence_of :status,
                        :guarantee,
                        :bonuses,
                        :radius_clause,
                        :total_expenses,
                        :gross_potential,
                        :door_times,
                        :age_range,
                        :merch_split,
                        :date,
                        :artist_name

  belongs_to :artist
  belongs_to :venue
  belongs_to :buyer

  enum status: { pending: 0, confirmed: 1, rejected: 2 }
end
