class Member::OrdersController < ApplicationController

  before_action :to_confirm, only: [:show]

  def index
    @orders = current_member.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @cart_items = current_member.cart_items
    current_member.cart_items.present? ? @order = Order.new : (render 'member/cart_items/index')
  end

  def confirm
    @order = current_member.orders.new(payment_method: params[:order][:payment_method])
    @new_ship = @order.set_new_order(confirm_params)
    if @new_ship.class == String
        flash.now[:danger] = @new_ship.html_safe
        render :new
    end
  end

  def create
    if @order = current_member.orders.create(order_params)
      @order.cart_to_order(current_member.cart_items)
      ship = current_member.ships.create(ship_params) if params[:order][:new_ship] == "true"
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

      def confirm_params
        params.require(:order).permit(:postal_code, :address, :name,
           :payment_method, :billing_amount, :ship_id, :ship_postal_code,
           :ship_name, :ship_address, :choice, :new_ship)
      end

      def order_params
        params.require(:order).permit(:postal_code, :address, :name,
           :payment_method, :billing_amount)
      end

      def ship_params
        params.require(:order).permit(:postal_code, :address, :name)
      end

end
