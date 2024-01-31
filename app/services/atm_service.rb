class AtmService
  def conn
    conn = Faraday.new(url: "https://api.tomtom.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.tomtom[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def search_atm(lat, lon)
    get_url("search/2/categorySearch/atm.json?lat=#{lat}&lon=#{lon}")
  end
end