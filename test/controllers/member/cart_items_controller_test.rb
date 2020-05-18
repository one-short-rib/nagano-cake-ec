require 'test_helper'

class Member::CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_cart_items_index_url
    assert_response :success
  end

end
