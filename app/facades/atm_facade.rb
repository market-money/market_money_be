class AtmFacade
  def search_results(lat, lon)
    json = AtmService.new.search_atm(lat, lon)
    results = json[:results].map do |atm_data|
      Atm.new(atm_data)
    end
    results.sort_by { |atm| atm.distance}
  end
end