require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'methods' do
    before do
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

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 1)

      @invoice_9 = Invoice.create!(customer: @customer_1, status: 2)

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id,
                                  item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id,
                                  item_id: @item_2.id, quantity: 100, unit_price: 10, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id,
                                  item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id,
                                  item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)

      @transaction_1 = Transaction.create!(credit_card_number: 203_942,
                                           result: 0, invoice_id: @invoice_1.id)
      @transaction_2 = Transaction.create!(credit_card_number: 230_948,
                                           result: 0, invoice_id: @invoice_2.id)
      @transaction_3 = Transaction.create!(credit_card_number: 234_092,
                                           result: 0, invoice_id: @invoice_3.id)

      @discount_1 = @merchant_1.bulk_discounts.create!(discount: 0.85,
                                                       threshold: 15)
      @discount_2 = @merchant_1.bulk_discounts.create!(discount: 0.25,
                                                       threshold: 10)
      @discount_3 = @merchant_1.bulk_discounts.create!(discount: 0.15,
                                                       threshold: 9)
      @discount_4 = @merchant_1.bulk_discounts.create!(discount: 0.75,
                                                       threshold: 5)
    end

    it 'returns incomplete invoices' do
      expect(InvoiceItem.incomplete_invoices).to include(@invoice_3, @invoice_1)
      expect(InvoiceItem.incomplete_invoices).to_not include(@invoice_2)
    end

    it 'can return best discount' do
      expect(@ii_1.best_discount).to eq(@discount_4)
      expect(@ii_2.best_discount).to eq(@discount_1)
    end

    it 'can return discoutned revenue' do
      expect(@ii_1.ii_discounted_revenue).to eq(22.5)
      expect(@ii_3.ii_discounted_revenue).to eq(16)
    end
  end
end
