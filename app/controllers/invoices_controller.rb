class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(invoice_item_params)
    redirect_to merchant_invoice_path(merchant, invoice)
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end