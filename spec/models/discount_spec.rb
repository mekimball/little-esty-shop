require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relations' do
    it { should belong_to :merchant }
  end
end
