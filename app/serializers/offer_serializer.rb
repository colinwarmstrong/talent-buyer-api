class OfferSerializer < ActiveModel::Serializer
  attributes :id, :venue_id, :artist_id, :buyer_id, :guarantee, :bonuses,
             :radius_clause, :total_expenses, :gross_potential,
             :door_times, :age_range, :merch_split, :date
end
