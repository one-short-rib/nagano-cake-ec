require 'test_helper'

class ItemInterfaceTest < ActionDispatch::IntegrationTest

  test "item idex view" do
    get items_path
    assert_select "h1", "商品一覧"
  end
  
end
