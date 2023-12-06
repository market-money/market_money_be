class Vendor < ApplicationRecord
  has_many :market_vendor 
  has_many :markets, through: :market_vendor 

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :contact_name
  validates_presence_of :contact_phone
  validates :credit_accepted, inclusion: [true, false]
end