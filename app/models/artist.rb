class Artist < ApplicationRecord
  validates_presence_of :name,
                        :genre,
                        :songkick_id
end
