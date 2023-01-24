class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    cart_item = CartItem.find_by(customer_id: current_customer, item_id: cart_item_params[:item_id])
    if cart_item
      new_quantity = @cart_item.amount + cart_item.amount
      cart_item.update(amount: new_quantity)
      @cart_item.destroy
      redirect_to cart_items_path
    else
      if @cart_item.save
        redirect_to cart_items_path
      else
        @genres = Genre.all
        @item = Item.find(params[:cart_item][:item_id])
        render 'public/items/show'
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
