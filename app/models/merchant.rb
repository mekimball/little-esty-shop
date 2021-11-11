class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def top_customers
    temp = Transaction.joins(invoice: :customer)
    .where("result =?", 0)
    .where("status =?", 1)
    .select("customers.*, count(transactions.id) as top_count")
    .group("customers.id")
    .order(top_count: :desc).limit(5)
    temp
  end

  def self.top_merchants
    temp = joins(invoices: :transactions)
          .where(transactions: {result: 0})
          .group('merchants.id')
          .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS item_revenue')
          .order(item_revenue: :desc)
          .limit(5)
    temp
  end

  def total_revenue
     total_revenue_table = invoices.joins(:transactions)
                                   .where(transactions: {result: :success})
                                   .group('invoices.id')
                                   .select('sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')

    if total_revenue_table.first != nil
      total_revenue_table.first.total_revenue
    else
      0
    end
  end

  def not_shipped
    item_ids = invoice_items.where.not(status: "2")
                            .order(:created_at)
                            .pluck(:item_id)
    item_ids.map do |item_id|
      Item.find(item_id)
    end.uniq
  end
end
