require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  describe 'Merchant Dashboard' do
    before(:each) do
      @merchant = Merchant.create!( name: 'Willms and Sons')
      @item1 = @merchant.items.create!(name: "Item 1", description: "An item", unit_price: 1300)
      @item2 = @merchant.items.create!(name: "Item 2", description: "Another 2item", unit_price: 1200)
      @item3 = @merchant.items.create!(name: "Item 3", description: "Another 3item", unit_price: 1200)
      @item4 = @merchant.items.create!(name: "Item 4", description: "Another 4item", unit_price: 1200)
      @customer1 = Customer.create!(first_name: "John", last_name: "Cena")
      @customer2 = Customer.create!(first_name: "Anakin", last_name: "Skywalker")
      @customer3 = Customer.create!(first_name: "Luke", last_name: "Jones")
      @customer4 = Customer.create!(first_name: "Leah", last_name: "Smith")
      @customer5 = Customer.create!(first_name: "Jar Jar", last_name: "Anderson")
      @customer6 = Customer.create!(first_name: "Hank", last_name: "Person")
      @invoice1 = @customer1.invoices.create!(status: 1)
      @invoice2 = @customer2.invoices.create!(status: 1)
      @invoice3 = @customer3.invoices.create!(status: 1)
      @invoice4 = @customer4.invoices.create!(status: 1)
      @invoice5 = @customer5.invoices.create!(status: 1)
      @invoice6 = @customer6.invoices.create!(status: 0)
      @invoice7 = @customer1.invoices.create!(status: 1)
      @invoice8 = @customer2.invoices.create!(status: 1)
      @invoice9 = @customer3.invoices.create!(status: 1)
      @invoice10 = @customer4.invoices.create!(status: 1)
      @invoice11 = @customer5.invoices.create!(status: 2)
      @invoice12 = @customer6.invoices.create!(status: 2)
      @invoice13 = @customer1.invoices.create!(status: 1)
      @invoice14 = @customer2.invoices.create!(status: 1)
      @invoice15 = @customer3.invoices.create!(status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 1300, status: 0)
      @ii2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 1300, status: 0)
      @ii3 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item2.id, quantity: 1, unit_price: 1300, status: 2)
      @ii4 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item3.id, quantity: 1, unit_price: 1300, status: 1)
      @ii5 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item3.id, quantity: 1, unit_price: 1300, status: 1)
      @ii6 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item4.id, quantity: 1, unit_price: 1300, status: 1)
      @ii7 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item4.id, quantity: 1, unit_price: 1300, status: 1)

      visit "/merchants/#{@merchant.id}/dashboard"
    end

    it 'shows merchant name' do
      expect(page).to have_content(@merchant.name)
    end

    it 'links to merchant items index' do
      click_on "Items Index"

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it 'links to merchant invoices index' do
      click_on "Invoices Index"

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    describe 'favorite customers' do
      xit 'i see names for top 5 customers' do
        expect(page).to have_content("Top 5 Customers:" )
        expect(@customer1.name).to appear_before(@customer2.name)
        expect(@customer2.name).to appear_before(@customer3.name)
        expect(@customer3.name).to appear_before(@customer4.name)
        expect(@customer4.name).to appear_before(@customer5.name)
        expect(page).to_not have_content(@customer6.name)
      end

      it 'i see number of successful transactions next to each customer' do

        
      end
    end

    describe 'Items ready to ship' do
      it 'has a ready to ship area' do

        expect(page).to have_content("Items Ready to Ship")
      end
      
      it 'shows items ready to ship' do
        
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item3.name)
        expect(page).to have_content(@item4.name)
        expect(page).to_not have_content(@item4.name)
      end
    end
  end
end
