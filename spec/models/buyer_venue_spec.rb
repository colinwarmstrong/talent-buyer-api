require 'rails_helper'

RSpec.describe BuyerVenue, type: :model do
  context 'Relationships' do
    it { should belong_to(:buyer) }
    it { should belong_to(:venue) }
  end
end
