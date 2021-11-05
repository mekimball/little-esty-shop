class CreateInvoice < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :customer, foreign_key: true
      t.column :status, :integer, default: 0

      t.timestamps
    end
  end
end
