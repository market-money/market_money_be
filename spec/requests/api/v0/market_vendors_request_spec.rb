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
  end
end