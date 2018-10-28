require 'rails_helper'

RSpec.describe Buyer, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
  end
  context 'Relationships' do
    it { should have_many(:offers) }
    it { should have_many(:buyer_venues) }
    it { should have_many(:venues).through(:buyer_venues) }
  end
end
