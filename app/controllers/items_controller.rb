class ItemsController < ApplicationController
  before_action :set_genres

  def index
    @items = Item.saled_items().page(params[:page]).per(8).reverse_order
    @count = Item.saled_items().count
  end

  def search
    @genre = Genre.find(params[:id])
    @items = saled_items(@genre).page(params[:page]).per(8).reverse_order
    @count = saled_items(@genre).count
    render :index
  end

  def show
    @item = Item.find(params[:id])
  end

  private
    def set_genres
      @genres = Genre.all
    end
end
