class Admin::OrdersController < ApplicationController

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
    @order.update
    redirect_back(fallback_location: root_path)
  end
end
