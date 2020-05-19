class Admin::OrderItemsController < ApplicationController

	#製作ステータスの変更
  def update
  	order_item = OrderItem.find(params[:id])
  	order_item.update
  	redirect_back(fallback_location: admin_top_path)
  end
end
