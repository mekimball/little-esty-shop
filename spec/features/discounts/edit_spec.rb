require 'rails_helper'

RSpec.describe 'Discount Edit Page', type: :feature do
  describe 'edit page' do
    before do
      @merchant_1 = Merchant.create!(name: 'Hair Care')
      @discount_1 = @merchant_1.bulk_discounts.create!(discount: 0.5,
                                                       threshold: 15)

      visit edit_merchant_bulk_discount_path(@merchant_1, @discount_1)
    end

    it 'can edit a discount' do
      fill_in 'discount', with: 0.20
      fill_in 'item_threshold', with: 12

      click_button 'Update'
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1,
                                                             @discount_1))

      expect(page).to have_content('Discount: 20.0%, Item Threshold: 12')
    end

    it 'can edit part of a discount' do
      fill_in 'item_threshold', with: 12

      click_button 'Update'
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1,
                                                             @discount_1))

      expect(page).to have_content('Discount: 50.0%, Item Threshold: 12')
    end
  end
end
