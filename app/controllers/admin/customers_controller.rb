class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(is_active: params[:customer][:is_active])
    flash[:notice] ="会員情報を更新しました"
    redirect_to admin_customer_path(@customer)
  end

end
