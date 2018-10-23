require 'rails_helper'

RSpec.describe Offer, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:guarantee) }
    it { should validate_presence_of(:bonuses) }
    it { should validate_presence_of(:radius_clause) }
    it { should validate_presence_of(:total_expenses) }
    it { should validate_presence_of(:gross_potential) }
    it { should validate_presence_of(:door_times) }
    it { should validate_presence_of(:age_range) }
    it { should validate_presence_of(:merch_split) }
  end
end
