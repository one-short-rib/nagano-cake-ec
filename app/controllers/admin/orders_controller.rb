class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
  	@orders = Order.all
  end

  def today
    now = Time.current
    @orders = Order.where(created_at: now.all_day)
    render 'index'
  end

  def personal
    #member = Member.find(params[:id])
    @orders = Order.where(member_id: params[:id])
    render 'index'
  end

  def show
  	@order = Order.find(params[:id])
  end

  def update
	  @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:success] = 'Success:更新が完了しました'
    #redirect_back(fallback_location: root_path)
  end

  def search
    @orders = Order.search(params[:term])
    render 'index'#viewの引用
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
