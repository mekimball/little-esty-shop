require 'rails_helper'

RSpec.describe 'Admin invoice show page' do
  describe 'page layout' do
    before(:each) do
      @customer = Customer.create!(first_name: 'John', last_name: 'Wick')
      @merchant = Merchant.create(name: 'Bob')
      @invoice = Invoice.create!(customer_id: @customer.id, status: 0)
      @item = Item.create!(name: 'Test Item', description: 'Just a thing',
                           unit_price: 1300, merchant_id: @merchant.id)
      @invoice_item = InvoiceItem.create!(item_id: @item.id,
                                          invoice_id: @invoice.id, quantity: 50, unit_price: 2000)

      visit admin_invoice_path(@invoice)
    end

    it 'shows the invoice header' do
      expect(page).to have_content("Invoice #{@invoice.id}")
    end

    it 'shows all the necessary information' do
      expect(page).to have_content(@invoice.status)
      expect(page).to have_content('November')
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end

    it 'shows invoice item info' do
      visit(admin_invoice_path(@invoice))

      expect(page).to have_content('Test Item')
      expect(page).to have_content(@invoice_item.quantity)
      expect(page).to have_content(@invoice_item.unit_price)
      expect(page).to have_content(@invoice_item.status)
    end

    it 'shows total revenue' do
      expect(page).to have_content("Total Revenue: #{@invoice.total_revenue}")
    end

    it 'can see and update invoice status' do
      visit(admin_invoice_path(@invoice))

      within('#status') do
        expect(page).to have_content(@invoice.status)
      end

      select('completed', from: 'invoice_status')

      within('#status') do
        click_button 'Update Invoice Status'
      end

      expect(current_path).to eq(admin_invoice_path(@invoice))

      within('#status') do
        expect(page).to have_content('completed')
      end
    end
  end
end
