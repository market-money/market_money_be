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

      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_an(Integer)
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

  it 'gets all vendors for a market' do
    # 3. Get all vendors for a market
    market = create(:market)
    vendor1 = create(:vendor)
    vendor2 = create(:vendor)
    MarketVendor.create!(market: market, vendor: vendor1)
    MarketVendor.create!(market: market, vendor: vendor2)

    get "/api/v0/markets/#{market.id}/vendors"

    expect(response).to be_successful

    vendors = JSON.parse(response.body, symbolize_names: true)[:data]

    vendors.each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_an(String)

      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to be_an(String)

      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
    end
  end

  it 'gives you an error if market ID does not exist' do
    # 3. Get all vendors for a market, sad path

    get "/api/v0/markets/1/vendors"
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
  end

  it 'searches market by state city and/or name' do
    # 10. Search markets, happy path
    market1 = create(:market, state: "Kansas")
    market2 = create(:market, state: "Colorado", city: "Denver")
    market3 = create(:market, state: "Colorado", city: "Denver", name: "REI")
    market4 = create(:market, state: "Colorado", name: "REI")
    market5 = create(:market, name: "REI")
    search_params = {
      state: "Colorado",
      city: "Denver",
      name: "REI"
    }
    headers = {"CONTENT_TYPE" => "application/json"}
    
    get '/api/v0/markets/search', headers: headers, params: search_params
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    search_results = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(search_results[0][:id]).to eq("#{market3.id}")
    expect(search_results[0][:attributes][:name]).to eq(market3.name)
    expect(search_results[0][:attributes][:city]).to eq(market3.city)
    expect(search_results[0][:attributes][:state]).to eq(market3.state)
  end

  it 'searches market by state city and/or name' do
    # 10. Search markets, happy path
    market1 = create(:market, state: "Kansas")
    market2 = create(:market, state: "Colorado", city: "Denver")
    market3 = create(:market, state: "Colorado", city: "Denver", name: "REI")
    market4 = create(:market, state: "Colorado", name: "REI")
    market5 = create(:market, name: "REI")

    search_params = ({
      name: "REI"
    })

    headers = {"CONTENT_TYPE" => "application/json"}
    
    get "/api/v0/markets/search", headers: headers, params: search_params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    search_results = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(search_results[0][:id]).to eq("#{market3.id}")
    expect(search_results[1][:id]).to eq("#{market4.id}")
    expect(search_results[2][:id]).to eq("#{market5.id}")
  end

  it 'errors with invalid params'do
  # 10 Search Market, sad path
    market1 = create(:market, state: "Kansas")
    market2 = create(:market, state: "Colorado", city: "Denver")
    market3 = create(:market, state: "Colorado", city: "Denver", name: "REI")
    market4 = create(:market, state: "Colorado", name: "REI")
    market5 = create(:market, name: "REI")

    search_params = ({
      city: "Denver"
    })

    headers = {"CONTENT_TYPE" => "application/json"}
    
    get "/api/v0/markets/search", headers: headers, params: search_params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("422")
    expect(data[:errors].first[:title]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")

  end

  it 'shows nearest atm' do
    #11 Get Cash, happy path
    market = create(:market, lat: "35.07904", lon: "-106.60068")
    data = File.read('spec/fixtures/nm_atms.json')
    stub_request(:get, "https://api.tomtom.com/search/2/categorySearch/atm.json?key=#{Rails.application.credentials.tomtom[:key]}&lat=35.07904&lon=-106.60068").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.7.12'
      }).
    to_return(status: 200, body: data, headers: {})

    get "/api/v0/markets/#{market.id}/nearest_atms"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    atm_search = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(atm_search.first).to have_key(:id)
    expect(atm_search.first[:id]).to eq(nil)

    expect(atm_search.first).to have_key(:type)
    expect(atm_search.first[:type]).to eq("atm")
    expect(atm_search.first[:attributes]).to have_key(:name)
    expect(atm_search.first[:attributes][:name]).to eq("ATM")
    expect(atm_search.first[:attributes][:address]).to eq("15 Fountain Alley, San Jose, CA 95113")
    expect(atm_search.first[:attributes][:lat]).to eq(37.335931)
    expect(atm_search.first[:attributes][:lon]).to eq(-121.889312)
    expect(atm_search.first[:attributes][:distance]).to eq(2.8319742817)
  end
end