class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:update]

	#全顧客の注文履歴一覧
  def index
  	@orders = Order.all
  end

  #1度の注文の注文履歴詳細
  def show
  	@order = Order.find(params[:id])
  end

  #注文ステータスの更新
  def update
	  @order = Order.find(params[:id])#注文idが渡っているけど、注文ステータスだけ取り出すことは面倒か？
    @order.update(order_params)
    flash[:success] = 'Success:更新が完了しました'
    redirect_back(fallback_location: root_path)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
