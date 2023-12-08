class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id]))
  end

  def search
    if params[:state] != nil && params[:city] != nil && params[:name] != nil
      markets = Market.market_search_all(params[:state], params[:city], params[:name])
      render json: MarketSerializer.new(markets), status: :ok
    elsif params[:city] == nil && params[:state] != nil && params[:name] != nil
      markets = Market.market_search_state_name(params[:state], params[:name])
      render json: MarketSerializer.new(markets), status: :ok
    elsif params[:name] == nil && params[:state] != nil && params[:city] != nil
      markets = Market.market_search_state_city(params[:state])
      render json: MarketSerializer.new(markets), status: :ok
    elsif params[:state] == nil && params[:city] == nil
      markets = Market.market_search_name(params[:name])
      render json: MarketSerializer.new(markets), status: :ok
    elsif params[:city] == nil && params[:name] == nil
      markets = Market.market_search_state(params[:state]) 
      render json: MarketSerializer.new(markets), status: :ok
    elsif params[:city] != nil || params[:name] != nil &&  params[:state] == nil
      render json: { errors: [title: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.", status: "422"]}, status: :unprocessable_entity
    # else
    #   render json: MarketSerializer.new(Market.all)
    end
  end

  def atm
    market = Market.find(params[:id])
    lat = market.lat
    lon = market.lon

    conn = Faraday.new(url: "https://api.tomtom.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.tomtom[:key]
    end

    response = conn.get("search/2/search/cash_dispenser.json?lat=#{lat}&lon=#{lon}")

    json = JSON.parse(response.body, symbolize_names: true)

    # results = json[:results].map do |atm_data|
      AtmSerializer.format_atm.(json)
    # end
  end
end