class Api::V0::VendorsController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  
  def index
    market = Market.find(params[:market_id])
    render json: VendorSerializer.new(market.vendors)
  end
end