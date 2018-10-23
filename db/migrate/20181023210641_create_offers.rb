class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.integer :status
      t.references :show, foreign_key: true
      t.references :artists, foreign_key: true
      t.integer :guarantee
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
