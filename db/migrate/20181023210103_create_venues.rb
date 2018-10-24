class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :name
      t.references :buyer, foreign_key: true
      t.text :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :capacity
    end
  end
end
