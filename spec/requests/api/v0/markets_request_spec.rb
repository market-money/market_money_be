require 'rails_helper'

describe 'Markets API' do
  it 'sends a list of markets' do
    # 1. Get all markets
    create_list(:market, 10)

    get '/api/v0/markets'
    
    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(markets.count).to eq(10)
    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(String)

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
    end
  end

  it "can get one market by its id" do
    # 2. Get one market, happy path
    id = create(:market).id
  
    get "/api/v0/markets/#{id}"
  
    market = JSON.parse(response.body, symbolize_names: true)[:data]
  
    expect(response).to be_successful

    expect(market).to have_key(:id)
    expect(market[:id]).to be_an(String)

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
  end

  it 'gives you an error if market ID does not exist' do
    # 2. Get one market, sad path

    get "/api/v0/markets/1"
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
  end
end