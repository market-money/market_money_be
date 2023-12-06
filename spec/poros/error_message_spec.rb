require 'rails_helper'

RSpec.describe ErrorMessage do
  it 'exist' do
    error = ErrorMessage.new('not found', 404)
    
    expect(error.message).to eq('not found')
    expect(error.status_code).to eq(404)
  end
end