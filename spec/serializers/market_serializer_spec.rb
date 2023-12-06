require 'rails_helper'

RSpec.describe MarketSerializer do
  describe 'market_serializer' do
    it 'creates data with market id, type and attributes' do
      create_list(:market, 3)
      market_serializer = MarketSerializer.new(Market.all).serializable_hash
      markets = market_serializer[:data]

      markets.each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_a(String)

        expect(market).to have_key(:type)
        expect(market[:type]).to eq(:market) # Ask about this

        expect(market).to have_key(:attributes)
        expect(market[:attributes]).to be_a(Hash)
        
        expect(market[:attributes]).to have_key(:name)
        expect(market[:attributes][:name]).to be_a(String)

        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes][:street]).to be_a(String)
        
        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes][:city]).to be_a(String)
        
        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes][:county]).to be_a(String)
        
        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes][:state]).to be_a(String)
        
        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes][:zip]).to be_a(String)
        
        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes][:lat]).to be_a(String)
        
        expect(market[:attributes]).to have_key(:lon)
        expect(market[:attributes][:lon]).to be_a(String)
        
        expect(market[:attributes]).to have_key(:vendor_count)
        expect(market[:attributes][:vendor_count]).to be_a(Integer)
      end
    end
  end
end