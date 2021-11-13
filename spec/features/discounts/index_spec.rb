require 'rails_helper'

RSpec.describe 'Discount Index Page', type: :feature do
  describe 'Discount Index' do
        before(:each) do
      @merchant_1 = Merchant.create!(name: 'Hair Care')
      @merchant_2 = Merchant.create!(name: 'Jewelry')
      @merchant_3 = Merchant.create!(name: 'Office Space')
      @merchant_4 = Merchant.create!(name: 'The Office')
      @merchant_5 = Merchant.create!(name: 'Office Improvement')
      @merchant_6 = Merchant.create!(name: 'Pens & Stuff')

      @item_1 = Item.create!(name: 'Shampoo',
                             description: 'This washes your hair', unit_price: 10, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: 'Conditioner',
                             description: 'This makes your hair shiny', unit_price: 8, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: 'Brush',
                             description: 'This takes out tangles', unit_price: 5, merchant_id: @merchant_1.id)
      @item_4 = Item.create!(name: 'Hair tie',
                             description: 'This holds up your hair', unit_price: 1, merchant_id: @merchant_1.id)
      @item_7 = Item.create!(name: 'Scrunchie',
                             description: 'This holds up your hair but is bigger', unit_price: 3, merchant_id: @merchant_1.id)
      @item_8 = Item.create!(name: 'Butterfly Clip',
                             description: 'This holds up your hair but in a clip', unit_price: 5, merchant_id: @merchant_1.id)

      @item_5 = Item.create!(name: 'Bracelet', description: 'Wrist bling',
                             unit_price: 200, merchant_id: @merchant_2.id)
      @item_6 = Item.create!(name: 'Necklace', description: 'Neck bling',
                             unit_price: 300, merchant_id: @merchant_2.id)

      @item_9 = Item.create!(name: 'Whiteboard', description: 'Erasable',
                             unit_price: 30, merchant: @merchant_3)
      @item_10 = Item.create!(name: 'Marker', description: 'Erasable',
                              unit_price: 3, merchant: @merchant_4)
      @item_11 = Item.create!(name: 'Eraser', description: 'Felt',
                              unit_price: 6, merchant: @merchant_5)
      @item_12 = Item.create!(name: 'Sharpie', description: 'Permanent',
                              unit_price: 4, merchant: @merchant_6)

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
      @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
      @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
      @customer_5 = Customer.create!(first_name: 'Sylvester',
                                     last_name: 'Nader')
      @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 1)
      @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 1)
      @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 1)
      @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
      @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)
      @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 1)

      @invoice_9 = Invoice.create!(customer: @customer_1, status: 2)

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id,
                                  item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id,
                                  item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id,
                                  item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id,
                                  item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
      @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id,
                                  item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
      @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id,
                                  item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
      @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id,
                                  item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
      @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id,
                                  item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
      @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id,
                                   item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_9.id,
                                   item_id: @item_9.id, quantity: 1, unit_price: 1, status: 1)
      @ii_12 = InvoiceItem.create!(invoice_id: @invoice_9.id,
                                   item_id: @item_10.id, quantity: 1, unit_price: 1, status: 1)
      @ii_13 = InvoiceItem.create!(invoice_id: @invoice_9.id,
                                   item_id: @item_11.id, quantity: 1, unit_price: 1, status: 1)
      @ii_14 = InvoiceItem.create!(invoice_id: @invoice_9.id,
                                   item_id: @item_12.id, quantity: 1, unit_price: 1, status: 1)

      @transaction_1 = Transaction.create!(credit_card_number: 203_942,
                                           result: 0, invoice_id: @invoice_1.id)
      @transaction_2 = Transaction.create!(credit_card_number: 230_948,
                                           result: 0, invoice_id: @invoice_2.id)
      @transaction_3 = Transaction.create!(credit_card_number: 234_092,
                                           result: 0, invoice_id: @invoice_3.id)
      @transaction_4 = Transaction.create!(credit_card_number: 230_429,
                                           result: 0, invoice_id: @invoice_4.id)
      @transaction_5 = Transaction.create!(credit_card_number: 102_938,
                                           result: 0, invoice_id: @invoice_5.id)
      @transaction_6 = Transaction.create!(credit_card_number: 879_799,
                                           result: 0, invoice_id: @invoice_6.id)
      @transaction_7 = Transaction.create!(credit_card_number: 203_942,
                                           result: 0, invoice_id: @invoice_7.id)
      @transaction_7 = Transaction.create!(credit_card_number: 203_942,
                                           result: 0, invoice_id: @invoice_8.id)
      @transaction_8 = Transaction.create!(credit_card_number: 203_942,
                                           result: 1, invoice_id: @invoice_9.id)
      @discount_1 = @merchant_1.bulk_discounts.create!(discount: 0.5, number_of_items_necessary: 15)
      @discount_2 = @merchant_1.bulk_discounts.create!(discount: 0.25, number_of_items_necessary: 10)
      @discount_3 = @merchant_1.bulk_discounts.create!(discount: 0.15, number_of_items_necessary: 5)
      @discount_4 = @merchant_2.bulk_discounts.create!(discount: 0.07, number_of_items_necessary: 7)

      visit merchant_bulk_discounts_path(@merchant_1)
      end
    it 'shows all discounts' do
      
      expect(page).to have_content("Discount: #{@discount_1.discount * 100}%, Item Threshold: #{@discount_1.number_of_items_necessary}")
      expect(page).to have_content("Discount: #{@discount_2.discount * 100}%, Item Threshold: #{@discount_2.number_of_items_necessary}")
      expect(page).to have_content("Discount: #{@discount_3.discount * 100}%, Item Threshold: #{@discount_3.number_of_items_necessary}")
      expect(page).to_not have_content("Discount: #{@discount_4.discount * 100}%, Item Threshold: #{@discount_4.number_of_items_necessary}")
    end

    it 'has links to each discount' do
      
      within "#id-#{@discount_1.id}" do
        click_link "Discount Details"
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @discount_1))
      end
    end
  end
end
# As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page