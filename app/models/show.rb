class Show < ApplicationRecord
  validates_presence_of :date,
                        :show_status
end
