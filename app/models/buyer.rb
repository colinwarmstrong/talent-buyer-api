class Buyer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name,
                        :email
  has_one :venue
  has_many :shows, through: :venue
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         jwt_revocation_strategy: JWTBlacklist
end
