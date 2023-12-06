class Vendor < ApplicationRecord
  has_many :market_vendor 
  has_many :markets, through: :market_vendor 

  validates :name, presence: true
  validates :description, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :credit_accepted, exclusion: { in: [nil] }
  validates_inclusion_of :credit_accepted, in: [true, false] 
end