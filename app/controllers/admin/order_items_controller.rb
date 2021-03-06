class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
  	@order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
    flash.now[:success] = 'Success:更新を完了しました'
    #redirect_back(fallback_location: root_path)
  end

  private
  def order_item_params
  	params.require(:order_item).permit(:making_status)
  end
end
