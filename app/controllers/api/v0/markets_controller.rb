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
    else
      render json: MarketSerializer.new(Market.all)
    end
  end
end