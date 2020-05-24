class ItemsController < ApplicationController
  before_action :set_genres

  def index
    @items = Item.page(params[:page]).per(8).reverse_order
  end

  def search
    @genre = Genre.find(params[:id])
    @items = @genre.items.page(params[:page]).per(8).reverse_order
  end

  def show
    @item = Item.find(params[:id])
  end

  private
    def set_genres
      @genres = Genre.all
    end
end
