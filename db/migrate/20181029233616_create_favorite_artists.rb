class CreateFavoriteArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_artists do |t|
      t.references :artist, foreign_key: true
      t.references :buyer, foreign_key: true
    end
  end
end
