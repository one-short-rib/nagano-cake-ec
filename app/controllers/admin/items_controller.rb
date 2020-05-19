class Admin::ItemsController < ApplicationController
  #商品新規登録ページの表示
  def new
    @item = Item.new
  end

  #商品の新規作成
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render 'new'
    end
  end

  #admin用の商品一覧表示
  def index
    @items = Item.all
  end

  #admin用商品詳細表示
  def show
    @item = Item.find(params[:id])
  end

  #商品編集ページ
  def edit
    @item = Item.find(params[:id])
  end

  #商品情報の変更・保存
  def update
    @item = Item.find(params[:id])
    if @item.update
      redirect_to admin_item_path(@item.id)
    else
      render 'show'
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :price, :item_image)
  end
end