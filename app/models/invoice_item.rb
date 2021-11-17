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
    BulkDiscount
      .where('bulk_discounts.threshold <= ? AND bulk_discounts.merchant_id = ?', quantity, item.merchant.id)
      .order(:discount)
      .last
  end

  def ii_discounted_revenue
    if best_discount.nil?
      unit_price * quantity
    else
      (unit_price * quantity) - (unit_price * quantity * best_discount.discount)
    end
  end
end
