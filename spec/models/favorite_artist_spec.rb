require 'rails_helper'

RSpec.describe FavoriteArtist, type: :model do
  context 'Relationships' do
    it { should belong_to(:buyer) }
    it { should belong_to(:artist) }
  end
end
