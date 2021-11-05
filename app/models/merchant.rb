class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  # def top_customers
  #   invoices.each do |invoice|
  #   require 'pry'; binding.pry
  # end
end
