class Member::CartItemsController < ApplicationController

  def index
  	@cart_items = current_member.cart_items.all
  end

  def create
  	@cart_item = current_member.cart_items.new(cart_item_params)
  	if @cart_item.save
  		redirect_to members_cart_items_path
  	else
			redirect_back(fallback_location: root_path)
		end
  end

  def update
  	@cart_item = CartItem.find(params[:id])
  	if params[:amount] == 0
  		@cart_item.destroy
		end
		@cart_item.update(cart_item_params)
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
