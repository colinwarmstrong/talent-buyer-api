class Show < ApplicationRecord
  validates_presence_of :date,
                        :show_status

  has_many :offers
  belongs_to :venue
end
