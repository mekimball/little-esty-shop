require 'rails_helper'

RSpec.describe 'item creation' do
  before(:each) do
    @merchant = Merchant.create!(name: 'Test Merchant')

    visit new_merchant_item_path(@merchant)
  end

  describe 'page layout' do
    it 'renders the new form' do
      expect(page).to have_content('New Item')

      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Unit price')
    end
  end

  describe 'item creation' do
    context 'given valid data' do
      it 'creates the item and redirects to the merchant items index' do
        fill_in 'Name', with: 'Sword of 1000 Truths'
        fill_in 'Description', with: 'A big sword'
        fill_in 'Unit price', with: 22_222
        click_button 'Create Item'

        expect(page).to have_current_path(merchant_items_path(@merchant))
        expect(page).to have_content('Sword of 1000 Truths')
      end
    end
    context 'given invalid data' do
      it 'rerenders the new form' do
        visit "/merchants/#{@merchant.id}/items/new"

        click_button 'Create Item'

        expect(page).to have_current_path("/merchants/#{@merchant.id}/items/new")
      end
    end
  end
end
