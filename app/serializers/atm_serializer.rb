class AtmSerializer
  attr_reader :info

  def format_atm(results)
    results.map do |result|
      {
        data: [
          { id: nil,
            type: "atm",
            attributes: {
              name: results[:poi][:name],
              address: results[:address][:freeformAddress],
              lat: results[:position][:lat],
              lon: results[:position][:lon],
              distance: results[:score] 
            }
          }
        ]
      }
    end
  end
end