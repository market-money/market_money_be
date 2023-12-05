require 'rails_helper'

RSpec.describe Vendor do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:contact_name) }
    it { should validate_presence_of(:contact_phone) }
    it { should validate_presence_of(:credit_accepted) }
    end
end