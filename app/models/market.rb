class Market < ApplicationRecord
  has_many :market_vendor 
  has_many :vendors, through: :market_vendor 

  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :county
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :lat
  validates_presence_of :lon

  def self.market_search_all(state, city, name)
    find_by_sql("select markets.* from markets where (markets.state = '#{state}' and markets.city = '#{city}' and markets.name = '#{name}')")
  end

  def self.market_search_name(name)
    find_by_sql("select markets.* from markets where (markets.name = '#{name}')")
  end

  def self.market_search_state_name(state, name)
    find_by_sql("select markets.* from markets where (markets.state = '#{state}' and markets.name = '#{name}')")
  end

  def self.market_search_state_city(state, city)
    find_by_sql("select markets.* from markets where (markets.state = '#{state}' and markets.city = '#{city}')")
  end

  def self.market_search_state(state)
    find_by_sql("select markets.* from markets where (markets.state = '#{state}')")
  end
end