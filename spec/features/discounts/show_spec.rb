require 'rails_helper'

RSpec.describe 'Discount Show Page', type: :feature do
  describe 'show page' do
    before do
      @merchant_1 = Merchant.create!(name: 'Hair Care')
      @discount_1 = @merchant_1.bulk_discounts.create!(discount: 0.5, threshold: 15)

      visit merchant_bulk_discount_path(@merchant_1, @discount_1)
    end
    it ' shows the discounts percentage and threshold' do
      expect(page).to have_content("Discount: #{@discount_1.discount * 100}%, Item Threshold: #{@discount_1.threshold}")
    end

    it 'has a link to edit a discount' do
      click_link 'Edit'

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @discount_1))
    end
  end
end
