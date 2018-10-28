class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.integer :status, default: 0
      t.references :buyer, foreign_key: true
      t.references :venue, foreign_key: true
      t.references :artist, foreign_key: true
      t.string :artist_name
      t.integer :guarantee
      t.date :date
      t.text :bonuses
      t.text :radius_clause
      t.integer :total_expenses
      t.integer :gross_potential
      t.text :door_times
      t.string :age_range
      t.text :merch_split
    end
  end
end
