require 'rails_helper'

RSpec.describe Show, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:show_status) }
  end
  context 'Relationships' do
    it { should belong_to(:venue) }
    it { should have_many(:offers) }
  end
end
