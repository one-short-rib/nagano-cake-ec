class Member::OrdersController < ApplicationController
  include Member::OrdersHelper

  before_action :to_confirm, only: [:show]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @cart_items = current_member.cart_items
    current_member.cart_items.count != 0 ? @order = Order.new : (render 'member/cart_items/index')
  end

  def confirm
    @order = Order.new(member: current_member,
                       payment_method: params[:order][:payment_method])
      case params[:order][:choice]
        when "0"
          @order.set_address(current_member)
        when "1"
          @order.set_address(current_member.ships.find(params[:order][:ship_id]))
        when "2"
          ship = current_member.ships.new(postal_code: params[:order][:ship_postal_code],
                                          name: params[:order][:ship_name],
                                          address: params[:order][:ship_address])
            @order.set_address(ship)
      end
        @order_items = cart_to_order
  end

  def create
    if current_member.orders.create(order_params)
      current_member.cart_items.destroy_all
      redirect_to thanks_members_orders_path
    else
      redirect_to members_cart_items_path
    end
  end

  def thanks
  end

  private

      def to_confirm
        redirect_to members_cart_items_path if params[:id] == "confirm"
      end

      def order_params
        params.require(:order).permit(:postal_code, :address, :name, :payment_method, :billing_amount)
      end

end
