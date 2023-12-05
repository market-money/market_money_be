require 'rails_helper'

RSpec.describe Market do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:county) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }
  end

  describe 'relationship' do
    it { should have_many(:market_vendor)}
    it { should have_many(:vendors).through(:market_vendor)}
  end
end