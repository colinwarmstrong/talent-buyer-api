class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.references :venues, foreign_key: true
      t.date :date
      t.integer :show_status, default: 0
    end
  end
end
