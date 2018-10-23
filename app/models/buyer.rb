class Buyer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name,
                        :email,
                        :phone
  belongs_to :venue

  has_one :venue
  has_many :shows, through: :venue
  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist
end
