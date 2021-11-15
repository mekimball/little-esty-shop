class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: %i[packaged pending shipped]

  def self.incomplete_invoices
    incomplete_invoices = InvoiceItem.where.not(status: 2)
                                     .distinct
                                     .pluck(:invoice_id)
    Invoice.order(:created_at).find(incomplete_invoices)
  end

  def best_discount
    discounts = item.merchant.bulk_discounts
    all_discounts = discounts.where("bulk_discounts.threshold <= #{self.quantity}")
    all_discounts.max_by do |discount|
      discount.discount
    end
  end
end
