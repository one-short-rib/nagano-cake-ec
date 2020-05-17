class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.where(id: 1 & 2 & 3 & 4)
  end

  def about
  end
end
