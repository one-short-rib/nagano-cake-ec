class HomesController < ApplicationController
  def top
    @genres = Genre.all
    Item.count > 3 ? @items = Item.all.sort_by{rand}.take(1..4) : @items = Item.take(1)
  end

  def about
  end
end
