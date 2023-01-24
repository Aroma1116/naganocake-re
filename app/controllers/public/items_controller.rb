class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    @params = params[:id]
    if @params
      @genre = Genre.find(@params)
      @items = @genre.items
    else
      @items = @items = Item.all
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
