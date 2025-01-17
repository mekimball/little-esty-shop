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
    BulkDiscount.create(discount: params[:discount], threshold: params[:item_threshold], merchant_id: params[:merchant_id])
    redirect_to merchant_bulk_discounts_path
  end

  def destroy
    discount = BulkDiscount.find(params[:id])
    discount.destroy
    redirect_to merchant_bulk_discounts_path
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    discount.update(discount: params[:discount], threshold: params[:item_threshold], merchant_id: params[:merchant_id])
    discount.save
    redirect_to merchant_bulk_discount_path(discount.merchant, discount)
  end
end