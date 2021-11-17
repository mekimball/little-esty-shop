require 'rails_helper'

RSpec.describe 'Admin invoice show page' do
  describe 'page layout' do
    before(:each) do
      @customer_1 = Customer.create!(first_name: 'John', last_name: 'Wick')
      @merchant_1 = Merchant.create(name: 'Bob')
      @merchant_2 = Merchant.create(name: 'Rob')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 0)
      @item_1 = Item.create!(name: 'Test Item', description: 'Just a thing',
                             unit_price: 1300, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: 'Test Item', description: 'Just a thing',
                             unit_price: 1300, merchant_id: @merchant_2.id)
      @ii_1 = InvoiceItem.create!(item_id: @item_1.id,
                                  invoice_id: @invoice_1.id, quantity: 50, unit_price: 2)
      @ii_2 = InvoiceItem.create!(item_id: @item_2.id,
                                  invoice_id: @invoice_1.id, quantity: 55, unit_price: 2)

      @discount_1 = @merchant_1.bulk_discounts.create!(discount: 0.5,
                                                       threshold: 15)
      @discount_2 = @merchant_1.bulk_discounts.create!(discount: 0.6,
                                                       threshold: 10)
      @discount_3 = @merchant_1.bulk_discounts.create!(discount: 0.15,
                                                       threshold: 5)
      @discount_4 = @merchant_2.bulk_discounts.create!(discount: 0.2,
                                                       threshold: 55)
      @discount_4 = @merchant_2.bulk_discounts.create!(discount: 0.3,
                                                       threshold: 50)

      visit admin_invoice_path(@invoice_1)
    end

    it 'shows the invoice header' do
      expect(page).to have_content("Invoice #{@invoice_1.id}")
    end

    it 'shows all the necessary information' do
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content('November')
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
    end

    it 'shows invoice item info' do
      visit(admin_invoice_path(@invoice_1))

      expect(page).to have_content('Test Item')
      expect(page).to have_content(@ii_1.quantity)
      expect(page).to have_content(@ii_1.unit_price)
      expect(page).to have_content(@ii_1.status)
    end

    it 'shows total revenue' do
      expect(page).to have_content("Total Revenue: #{@invoice_1.total_revenue}")
    end

    it 'can see and update invoice status' do
      visit(admin_invoice_path(@invoice_1))

      within('#status') do
        expect(page).to have_content(@invoice_1.status)
      end

      select('completed', from: 'invoice_status')

      within('#status') do
        click_button 'Update Invoice Status'
      end

      expect(current_path).to eq(admin_invoice_path(@invoice_1))

      within('#status') do
        expect(page).to have_content('completed')
      end
    end

    it 'returns discounted revenue' do
      expect(page).to have_content('Discounted Revenue: 117.0')
    end
  end
end
# Admin Invoice Show Page: Total Revenue and Discounted Revenue

# As an admin
# When I visit an admin invoice show page
# Then I see the total revenue from this invoice (not including discounts)
# And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
