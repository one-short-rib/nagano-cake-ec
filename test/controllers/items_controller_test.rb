require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get items_path
    assert_response :success
  end

  test "should get show" do
    get item_path(items(:item1))
    assert_response :success
  end

end
