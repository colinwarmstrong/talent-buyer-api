class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.string :first_name
      t.string :last_name
      t.references :venues, foreign_key: true
      t.string :email
      t.integer :phone
    end
  end
end
