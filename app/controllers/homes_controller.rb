class HomesController < ApplicationController
  def top
    @genres = Genre.all
    Item.saled_items.count > 3 ?
    @items = Item.saled_items.all.sort_by{rand}.first(4) : @items = Item.saled_items.take(1)
  end

  def about
  end
end
