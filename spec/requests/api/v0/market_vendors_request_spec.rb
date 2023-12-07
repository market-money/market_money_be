require 'rails_helper'

describe 'Market Vendors API' do
  it 'creates a market vendor' do
    # 8. Create a market vendor, happy path
    market = create(:market).id
    vendor = create(:vendor).id

    market_vendor_params= {
      "market_id": market,
      "vendor_id": vendor
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v0/market_vendors', headers: headers, params:  JSON.generate(market_vendor: market_vendor_params) 
    
    expect(response).to be_successful
    expect(response.status).to eq(201)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:message]).to eq("Successfully added vendor to market")
  end

  it 'does not create if market or vendor does not exist' do
    # 8. Create a market vendor, sad path
    vendor = create(:vendor).id

    market_vendor_params= {
      "market_id": 1234,
      "vendor_id": vendor
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v0/market_vendors', headers: headers, params:  JSON.generate(market_vendor: market_vendor_params) 
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Validation failed: Market must exist")
  end

  it 'does not create if market or vendor already exist' do
    # 8. Create a market vendor, sad path
    vendor = create(:vendor)
    market = create(:market)

    market_vendor = MarketVendor.create(market: market, vendor: vendor)

    market_vendor_params= {
      "market_id": market.id,
      "vendor_id": vendor.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v0/market_vendors', headers: headers, params:  JSON.generate(market_vendor: market_vendor_params) 
    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("422")
    expect(data[:errors].first[:title]).to eq("Validation failed: Market vendor association between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists")
  end
end