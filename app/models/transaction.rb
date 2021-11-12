class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: %i[success failed]

  validates_presence_of :credit_card_number
  validates_presence_of :result
end
