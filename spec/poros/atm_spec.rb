require 'rails_helper'

RSpec.describe Atm do
  describe 'atm' do
    it 'exist' do
      data = {
        address: {
          freeformAddress: 'test'
        },
        position: { 
          lat: 1,
          lon: 2
        },
        score: 2
      }
      data1 = Atm.new(data)
      expect(data1.name).to eq('ATM')
      expect(data1.address).to eq('test')
      expect(data1.lat).to eq(1)
      expect(data1.lon).to eq(2)
      expect(data1.distance).to eq(2)
    end
  end
end