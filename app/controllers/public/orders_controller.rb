class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_items_exists, only:[:new, :confirm]

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
    else
      flash[:notice] ="お届け先を選んでください。"
      redirect_to new_order_path
    end
  end

  def thanks
  end

  def create
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      @order_detail.save
      @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render "new"
    end

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

  def cart_items_exists
    unless current_customer.cart_items.exists?
      flash[:notice] = "カートの中身が空です。カートに商品を追加してください。"
      redirect_to cart_items_path
    end
  end

end
