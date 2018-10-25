class Show < ApplicationRecord
  validates_presence_of :date,
                        :show_status

  has_many :offers
  belongs_to :venue

  enum show_status: { open: 0, confirmed: 1, passed: 2, cancelled: 3 }
end
