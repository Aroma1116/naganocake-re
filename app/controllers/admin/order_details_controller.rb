class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    is_updated = true
    if @order_detail.update(order_detail_params)
      if @order_details.where(making_status: 2).count >= 1
        @order.update(status: 2)
      end
      @order_details.each do |order_detail|
        if order_detail.making_status != "completion_of_production"
          is_updated = false
        end
      end
      @order.update(status: 3) if is_updated == true
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
