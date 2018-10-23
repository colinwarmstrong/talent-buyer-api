class AddUsernameAndPasswordToBuyers < ActiveRecord::Migration[5.2]
  def change
    add_column :buyers, :username, :string
    add_column :buyers, :password_digest, :string
  end
end
