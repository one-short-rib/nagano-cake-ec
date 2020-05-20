class Admin::OrderItemsController < ApplicationController

	#製作ステータスの変更
  def update
  	@order = OrderItem.find(params[:id])
    @order.update(order_item_params)
    redirect_back(fallback_location: root_path)
  end

  private
  def order_item_params
  	params.require(:order_item).permit(:making_status)
  end
end
