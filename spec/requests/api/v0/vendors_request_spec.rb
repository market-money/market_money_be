require 'rails_helper'

describe 'Vendors API' do
  it 'can get one vendor by its id' do
    # 4. Get one vendor, happy path

    id = create(:vendor).id

    get "/api/v0/vendors/#{id}"

    expect(response).to be_successful

    vendor = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(vendor).to have_key(:id)
    expect(vendor[:id]).to be_an(String)

    expect(vendor).to have_key(:type)
    expect(vendor[:type]).to be_an(String)

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

  it 'only provides info if vendor id exist' do
    # 4. Get one vendor, sad path
    get "/api/v0/vendors/1"
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
  end

  it 'can create a vendor' do
    # 5. Create a vendor, happy path
    vendor_params = ({
      "name": "Buzzy Bees",
      "description": "local honey and wax products",
      "contact_name": "Berly Couwer",
      "contact_phone": "8389928383",
      "credit_accepted": false
    })

    headers = {"CONTENT_TYPE" => "application/json"}
    
    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

    created_vendor = Vendor.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end

  it 'does not create vendor if not all attributes are provided' do
    # 5. Create a vendor, sad path
    vendor_params = ({
      "name": "Buzzy Bees",
      "description": "local honey and wax products",
      "credit_accepted": false
    })

    headers = {"CONTENT_TYPE" => "application/json"}
    
    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("400")
    # expect(data[:errors].first[:title]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
  end

  it 'can update a vendor' do
    # 6. Update a vendor, happy path
    id = create(:vendor).id
    previous_params = Vendor.last.name
    vendor_params = ({
      "name": "Bees Knees"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    
    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate(vendor: vendor_params)
    
    vendor = Vendor.find_by(id: id)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(vendor.name).to_not eq(previous_params)
    expect(vendor.name).to eq(vendor_params[:name])
  end

  it 'cannot update a vendor with invalid id' do
    # 6 Update a vendor, sad path with no id
    patch "/api/v0/vendors/1"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
  end

  it 'can delete a vendor' do
    # 7. Delete a vendor, happy path
    vendor = create(:vendor)

    expect(Vendor.count).to eq(1)

    delete "/api/v0/vendors/#{vendor.id}"
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Vendor.count).to eq(0)
    expect{Vendor.find(vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'cannot delete a vendor with invalid id' do
    # 7 Delete a vendor, sad path

    delete "/api/v0/vendors/1"
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
  end
end