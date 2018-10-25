class CreateBuyerVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :buyer_venues do |t|
      t.references :buyer, foreign_key: true
      t.references :venue, foreign_key: true
    end
  end
end
