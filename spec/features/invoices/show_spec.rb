require 'rails_helper'

RSpec.describe 'Show page', type: :feature do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @merchant_2 = Merchant.create!(name: 'Jewelry')

    @item_1 = Item.create!(name: 'Shampoo',
                           description: 'This washes your hair', unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Bracelet', description: 'Wrist bling',
                           unit_price: 200, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: 'Bracelet 2', description: 'Wrist bling',
                           unit_price: 200, merchant_id: @merchant_2.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Joy', last_name: 'Smith')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id,
                                quantity: 9, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id,
                                quantity: 1, unit_price: 10, status: 1)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id,
                                quantity: 2, unit_price: 8, status: 2)

    @discount_1 = @merchant_1.bulk_discounts.create!(discount: 0.5, threshold: 15)
    @discount_2 = @merchant_1.bulk_discounts.create!(discount: 0.25, threshold: 10)
    @discount_3 = @merchant_1.bulk_discounts.create!(discount: 0.10, threshold: 5)

    visit merchant_invoice_path(@merchant_1, @invoice_1)
  end

  describe 'invoice show page' do
    it 'shows invoice information' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content("Created at: #{@invoice_1.created_at.strftime('%A, %B %e, %Y')}")
    end

    it 'shows invoice customer details' do
      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
    end

    it 'shows item information' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@ii_1.unit_price)
      expect(page).to have_content(@ii_1.quantity)
      expect(page).to have_content(@ii_1.status)

      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@ii_2.unit_price)
      expect(page).to have_content(@ii_2.quantity)
      expect(page).to have_content(@ii_2.status)

      expect(page).to_not have_content(@item_3.name)
    end

    it 'shows total revenue' do
      expect(page).to have_content('Total Revenue: 100')
    end

    it 'shows a drop menu for invoice item status' do
      within("#id-#{@ii_1.id}") do
        select 'pending', from: 'Invoice Status'
        click_button 'Update Item Status'
      end

      @ii_1.reload
      expect(@ii_1.status).to eq('pending')
    end
  end

  describe 'invoice discounts' do
    it 'can show discounted revenue' do

      expect(page).to have_content("Discounted Revenue: 91")
    end
  end
end
# As a merchant
# When I visit my merchant invoice show page
# Then I see the total revenue for my merchant from this invoice (not including discounts)
# And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation