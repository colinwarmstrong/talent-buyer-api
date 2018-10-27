class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :agency
      t.string :image_url
      t.integer :popularity
      t.integer :songkick_id
      t.string :spotify_url
      t.string :spotify_id
      t.integer :spotify_followers
    end
  end
end
