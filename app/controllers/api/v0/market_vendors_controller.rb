class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_not_found_response
  rescue_from ActiveRecord::RecordNotUnique, with: :render_unprocessable_entity_response

  def create
    market_vendor = MarketVendor.new(market_vendor_params)
    existing_market_vendor = MarketVendor.find_by(market_vendor_params)

    if existing_market_vendor 
      render_unprocessable_entity_response(existing_market_vendor)
    elsif market_vendor.save
      render json: { message: "Successfully added vendor to market"}, status: :created
    else
      render_not_found_response(market_vendor)
    end
  end

  def destroy
    existing_market_vendor = MarketVendor.find_by(market_vendor_params)
    
    if existing_market_vendor
      render json: existing_market_vendor.destroy
      head :no_content
    else
      no_id_error_message
    end

  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def render_not_found_response(exception)
    render json: ErrorSerializer.new(ValidationErrorMessage.new(exception.errors.full_messages.join(', '), 404)).serialize_json, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    # require 'pry'; binding.pry
    # render json: ErrorSerializer.new(DuplicateErrorMessage.new(exception.errors, 422)).serialize_json, status: :not_found

    render json: { errors: [title: "Validation failed: Market vendor association between market with market_id=#{params[:market_vendor][:market_id]} and vendor_id=#{params[:market_vendor][:vendor_id]} already exists", status: "422"] }, status: :unprocessable_entity
  end

  def no_id_error_message
    render json: { errors: [title: "No MarketVendor with market_id=#{params[:market_vendor][:market_id]} AND vendor_id=#{params[:market_vendor][:vendor_id]} exists", status: "404"] }, status: :not_found
  end
end