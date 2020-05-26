class Member::CartItemsController < ApplicationController
  include ApplicationHelper
  before_action :limited_member

  def index
  	@cart_items = current_member.cart_items.all
  end

  def create
  	@cart_items = current_member.cart_items.all
  	@cart_item = current_member.cart_items.new(cart_item_params)
  	# もしカートに同じ商品が存在する場合、古いものを消して新しいものを保存する
    @existing_cart_item =  @cart_items.find_by(item_id: @cart_item.item_id)
  	if @existing_cart_item.present?
			@existing_cart_item.destroy
  	end
  	if @cart_item.save
        flash[:notice] = "カートに商品を追加しました"
  		redirect_to members_cart_items_path
  	else
        flash[:danger] = "個数を選択してください"
		redirect_back(fallback_location: root_path)
	end
  end

  def update
  	@cart_item = CartItem.find(params[:id])
    @amount = params[:cart_item][:amount]
    @total = total_price(current_member.cart_items).to_s(:delimited)
    if  @amount == '0'
  		@cart_item.destroy
      flash.now[:danger]= "カートから商品を1点削除しました"
    else
      @cart_item.update(cart_item_params)
      @subtotal = subtotal_price(@cart_item).to_s(:delimited)
      flash.now[:success]= "カート内商品の数量を変更しました"
    end
    respond_to do |format|
			format.html {redirect_to members_cart_items_path}
			format.js
	end
  end

  def destroy
  	@cart_item = CartItem.find(params[:id])
  	@cart_item.destroy
    flash.now[:danger]="カートから商品を1点削除しました"
    respond_to do |format|
			format.html {redirect_to members_cart_items_path}
			format.js
	end
  end

  def clear
  	@cart_items = current_member.cart_items.all
  	@cart_items.destroy_all
    flash[:danger]= "カート内の全商品を削除しました"
		redirect_to members_cart_items_path
  end


  private
  def cart_item_params
  	params.require(:cart_item).permit(:item_id,:amount)
  end

  def limited_member
    unless current_member
      flash[:danger]="会員登録しないと購入できません"
      redirect_back(fallback_location: root_path)
    end
  end

end
