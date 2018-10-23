require 'rails_helper'

RSpec.describe Show, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:show_status) }
  end
end
