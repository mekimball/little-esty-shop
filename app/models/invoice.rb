class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items, source: :invoice_items

  enum status: [:cancelled, :completed, 'in progress']

  validates_presence_of :customer_id
  validates_presence_of :status

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end

  def discounted_revenue
    self.invoice_items.map do |ii|
      ii.discounted_revenue
    end.sum
  end
end
