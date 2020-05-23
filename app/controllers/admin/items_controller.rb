class Admin::ItemsController < ApplicationController
  #商品新規登録ページの表示
  def new
    @item = Item.new
  end

  #商品の新規作成
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = 'Success:登録が完了しました'
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:danger] = 'False:登録に失敗しました'
      render 'new'
    end
  end

  #admin用の商品一覧表示
  def index
    @items = Item.page(params[:page]).reverse_order
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
    if @item.update(item_params)
      flash[:success] = 'Success:編集が完了しました'
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:danger] = 'False:編集に失敗しました'
      render 'edit'
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :price, :item_image, :genre_id, :is_saled)
  end
end
