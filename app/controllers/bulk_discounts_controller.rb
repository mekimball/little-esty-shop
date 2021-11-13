class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = BulkDiscount.where(merchant_id: params[:merchant_id])
  end
  
  def show
    @discount = BulkDiscount.find(params[:id])
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    BulkDiscount.create(discount: params[:discount], number_of_items_necessary: params[:item_threshold], merchant_id: params[:merchant_id])
    redirect_to merchant_bulk_discounts_path
  end
end