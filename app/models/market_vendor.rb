class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validates_presence_of :market_id
  validates_presence_of :vendor_id
end