class Member::OrdersController < ApplicationController
  include Member::OrdersHelper

  before_action :to_confirm, only: [:confirm]

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
    @order_items = []
    current_member.cart_items.each do |cart_item|
      @order_items << OrderItem.new(item: cart_item.item,
                             amount: cart_item.amount,
                             order_price: tax_include(cart_item.item.price))
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

      def to_confirm
        redirect_to members_cart_items_path if params[:id] == "confirm"
      end

end
