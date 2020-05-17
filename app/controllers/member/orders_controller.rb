class Member::OrdersController < ApplicationController

  def new
    #@cart_items = current_member.cart_items
    #@cart_items = CartItem.all
  #  if current_member.cart_items.count != 0
    @order = Order.new
    #clear(@cart_items)
    #else
    #  @cart_items.errors.add(:base, '商品を追加してください')
    #  render 'member/cart_items/index'
    #end
  end

  def create
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
  end

  def thanks
  end

end
