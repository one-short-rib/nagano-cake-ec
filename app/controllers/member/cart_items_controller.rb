class Member::CartItemsController < ApplicationController

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
  		redirect_to members_cart_items_path
  	else
			redirect_back(fallback_location: root_path)
		end
  end

  def update
  	@cart_item = CartItem.find(params[:id])
    if params[:cart_item][:amount] == '0'
  		@cart_item.destroy
    else
      @cart_item.update(cart_item_params)
    end
    redirect_to members_cart_items_path
  end

  def destroy
  	@cart_item = CartItem.find(params[:id])
  	@cart_item.destroy
		redirect_to members_cart_items_path
  end

  def clear
  	@cart_items = current_member.cart_items.all
  	@cart_items.destroy_all
		redirect_to members_cart_items_path
  end


  private
  def cart_item_params
  	params.require(:cart_item).permit(:item_id,:amount)
  end


end
