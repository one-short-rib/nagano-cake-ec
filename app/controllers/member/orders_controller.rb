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
          @order.postal_code = current_member.postal_code
          @order.address = current_member.address
          @order.name = current_member.last_name + current_member.first_name
    elsif params[:order][:name] == "1"
         ship = current_member.ships.find(params[:order][:address])
         @order.postal_code = ship.postal_code
         @order.address = ship.address
         @order.name = ship.name
    else
        ship = Ship.find(ship_params)
        @order.postal_code = ship.postal_code
        @order.address = ship.address
        @order.name = ship.name
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

    def ship_params
      params.require(:ship).permit(:postal_code, :address, :name)
    end

end
