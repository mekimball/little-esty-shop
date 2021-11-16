require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    @item_1 = Item.create!(name: 'Shampoo',
                           description: 'This washes your hair', unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Bracelet', description: 'Wrist bling',
                           unit_price: 200, merchant_id: @merchant_1.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Joy', last_name: 'Smith')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: 0)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id,
                                quantity: 9, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id,
                                quantity: 1, unit_price: 10, status: 0)

      @discount_1 = @merchant_1.bulk_discounts.create!(discount: 0.5, threshold: 15)
      @discount_2 = @merchant_1.bulk_discounts.create!(discount: 0.25, threshold: 10)
      @discount_3 = @merchant_1.bulk_discounts.create!(discount: 0.15, threshold: 5)
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :status }
  end

  describe 'methods' do
    it 'can return total invoice revenue' do
      expect(@invoice_1.total_revenue).to eq(100)
    end

    it 'can return discounted revenue' do
      expect(@invoice_1.discounted_revenue).to eq(86.5)
    end
  end
end
