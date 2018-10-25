class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :agency
      t.integer :artist_songkick_id
      t.integer :artist_spotify_id
    end
  end
end
