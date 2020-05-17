class ItemsController < ApplicationController
  before_action :set_genres

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    #@cart_item = CartItem.new
  end

  private
    def set_genres
      #@genres = Genre.all
    end
end
