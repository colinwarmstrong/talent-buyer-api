class Offer < ApplicationRecord
  validates_presence_of :status,
                        :guarantee,
                        :bonuses,
                        :radius_clause,
                        :total_expenses,
                        :gross_potential,
                        :door_times,
                        :age_range,
                        :merch_split

  belongs_to :artist
  belongs_to :show
end
