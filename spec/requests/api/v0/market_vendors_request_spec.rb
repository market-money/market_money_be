require 'rails_helper'

describe 'Market Vendors API' do
  it 'sends a list of markets' do
    # 1. Get all markets
    create_list(:market, 10)

    # get '/api/v0/markets',

  end
end