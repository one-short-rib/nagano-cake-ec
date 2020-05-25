class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
  	@orders = Order.all
  end
  def show
  	@order = Order.find(params[:id])
  end
  def update
	  @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:success] = 'Success:更新が完了しました'
    redirect_back(fallback_location: root_path)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
