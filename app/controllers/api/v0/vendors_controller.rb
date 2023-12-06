class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  
  def index
    market = Market.find(params[:market_id])
    render json: VendorSerializer.new(market.vendors)
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.new(vendor_params)
    
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render_unprocessable_entity_response(vendor)
    end
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      render json: VendorSerializer.new(Vendor.update(vendor_params))
    else
      render_unprocessable_entity_response(vendor)
    end
  end

  def destroy
    Vendor.find(params[:id]).destroy!
    head :no_content
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.errors.full_messages.join(', '), 400)).serialize_json, status: :bad_request
  end
end