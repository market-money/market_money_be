require 'rails_helper'

RSpec.describe AtmSerializer do
  describe 'atm serializer' do
    it 'exist' do
      data = File.read('spec/fixtures/nm_atms.json')
      stub_request(:get, "https://api.tomtom.com/search/2/categorySearch/atm.json?key=#{Rails.application.credentials.tomtom[:key]}&lat=1&lon=2").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.7.12'
        }).
      to_return(status: 200, body: data, headers: {})
      facade = AtmFacade.new.search_results(1, 2)
      test = AtmSerializer.new(facade).serializable_hash
      expect(test[:data][0]).to have_key(:id)
      expect(test[:data][0]).to have_key(:type)
      expect(test[:data][0]).to have_key(:attributes)
    end
  end
end