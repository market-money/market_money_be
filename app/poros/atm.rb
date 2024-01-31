class Atm
  attr_reader :name, :address, :lat, :lon, :distance, :id

  def initialize(results)
    @name = 'ATM'
    @id = nil
    @address = results[:address][:freeformAddress]
    @lat = results[:position][:lat]
    @lon = results[:position][:lon]
    @distance = results[:score] 
  end

end