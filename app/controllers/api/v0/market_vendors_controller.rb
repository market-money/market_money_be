class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def create
    market_vendor = MarketVendor.new(market_vendor_params)
    if market_vendor.save
      render json: MarketVendorSerializer.new(market_vendor), status: :created
    else
      render_unprocessable_entity_response(market_vendor)
    end
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: ErrorSerializer.new(ValidationErrorMessage.new(exception.errors.full_messages.join(', '), 404)).serialize_json, status: :not_found
  end
end