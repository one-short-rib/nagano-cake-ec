require 'test_helper'

class Member::OrdersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_members_order_path
    assert_response :success
  end

  test "should get index" do
    get members_orders_path
    assert_response :success
  end

  test "should get show" do
    get members_order_path(1)
    assert_response :success
  end

end
