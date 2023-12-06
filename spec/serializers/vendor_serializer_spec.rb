require 'rails_helper'

RSpec.describe VendorSerializer do
  describe 'vendor_serializer' do
    it 'creates data with vendor id, type and attributes' do
      create_list(:vendor, 3)
      vendor_serializer = VendorSerializer.new(Vendor.all).serializable_hash
      vendors = vendor_serializer[:data]

      vendors.each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id]).to be_a(String)

        expect(vendor).to have_key(:type)
        expect(vendor[:type]).to eq(:vendor) # Ask about this

        expect(vendor).to have_key(:attributes)
        expect(vendor[:attributes]).to be_a(Hash)
        
        expect(vendor[:attributes]).to have_key(:name)
        expect(vendor[:attributes][:name]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:description)
        expect(vendor[:attributes][:description]).to be_a(String)
        
        expect(vendor[:attributes]).to have_key(:contact_name)
        expect(vendor[:attributes][:contact_name]).to be_a(String)
        
        expect(vendor[:attributes]).to have_key(:contact_phone)
        expect(vendor[:attributes][:contact_phone]).to be_a(String)
        
        expect(vendor[:attributes]).to have_key(:credit_accepted)
        expect(vendor[:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
      end
    end
  end
end
