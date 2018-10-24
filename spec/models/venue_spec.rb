require 'rails_helper'

RSpec.describe Venue, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:capacity) }
  end
  context 'Relationships' do
    it { should belong_to(:buyer) }
    it { should have_many(:shows) }
  end
end