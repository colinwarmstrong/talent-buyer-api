require 'rails_helper'

RSpec.describe Artist, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:agency) }
    it { should validate_presence_of(:popularity) }
    it { should validate_presence_of(:songkick_id) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:spotify_followers) }
    it { should validate_presence_of(:spotify_id) }
  end
  context 'Relationships' do
    it { should have_many(:offers) }
  end
end
