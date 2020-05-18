class Member::OrdersController < ApplicationController

  def new
    @cart_items = current_member.cart_items
    if current_member.cart_items.count != 0
      @order = Order.new
    else
      #flash[:danger] = '商品を追加してください'
      render 'member/cart_items/index'
    end
  end

  def create
    binding.pry
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

  private
    def order_params
      params.require(:order).permit(:name, :address, :payment_method)
    end

end
