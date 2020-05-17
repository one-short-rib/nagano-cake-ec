class Member::OrdersController < ApplicationController

  def new
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
