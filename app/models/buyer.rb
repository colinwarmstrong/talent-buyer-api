class Buyer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name,
                        :email
                        
  has_many :buyer_venues
  has_many :venues, through: :buyer_venues

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         jwt_revocation_strategy: JWTBlacklist
end
