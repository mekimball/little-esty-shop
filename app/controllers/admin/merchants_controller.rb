class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant.update(merchant_params)
    flash[:success] = 'Merchant updated'
    redirect_to admin_merchant_path(merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
