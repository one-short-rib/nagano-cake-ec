require 'test_helper'

class ItemInterfaceTest < ActionDispatch::IntegrationTest

  # def setup
  #   @item = items(:item1)
  # end

  test "item idex view" do
    get items_path
    assert_select "h1", "商品一覧"
  end

  test "item show view" do
    # get item_path(@item)
  end

end
