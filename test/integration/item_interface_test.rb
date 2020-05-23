require 'test_helper'

class ItemInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @item = items(:item1)
    @genre = genres(:genre1)
  end

  test "item idex view" do
    get items_path
    assert_template 'items/index'
    assert_match @genre.name, response.body
    assert_select "h1", "商品一覧 (全#{Item.count}件)"
    assert_match Item.count.to_s, response.body
    assert_match @item.price.to_s(:delimited), response.body
    assert_match @item.name, response.body
  end

  test "item show view" do
    get item_path(@item)
    assert_template 'items/show'
    assert_match @genre.name, response.body
    assert_match @item.price.to_s(:delimited), response.body
    assert_match @item.name, response.body
    assert_select "input[type=?]", "number"
    assert_select "input[value=?]", "カートに入れる"
  end

end
