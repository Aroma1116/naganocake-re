class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(status: params[:order][:status])
      if @order.status == "payment_confirmation"
        @order.order_details.each do |order_detail|
          order_detail.update(making_status: 1)
        end
      end
    end
    redirect_back(fallback_location: root_path)
  end

end
