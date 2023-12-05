require 'rails_helper'

describe 'Markets API' do
  it 'sends a list of markets' do
    create_list(:markets, 10)

    get '/api/v0/markets'
    
    expect(response).to be_successful
  end
end