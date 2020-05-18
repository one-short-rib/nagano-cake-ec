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

  def confirm
    @order = Order.new(member: current_member,
                      payment_method: params[:order][:payment_method])
    if params[:order][:name] == "0"
          @order.set_address(current_member)
    elsif params[:order][:name] == "1"
         ship = current_member.ships.find(params[:order][:address])
         @order.set_address(ship)
    else
        ship = current_member.ships.new(postal_code: params[:order][:ship_postal_code],
                                        name: params[:order][:ship_name],
                                        address: params[:order][:ship_address])
        @order.set_address(ship)
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def thanks
  end

  private
    def order_params
      params.require(:order).permit(:name, :address, :payment_method)
    end

end
