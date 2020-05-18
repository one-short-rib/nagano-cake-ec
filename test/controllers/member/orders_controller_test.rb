require 'test_helper'

class Member::OrdersControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  test "should get new" do
    member = members(:member2)
    login_as(member, :scope => :member)
    get new_members_order_path
    assert_response :success
  end

  test "should get index" do
    get members_orders_path
    assert_response :success
  end

  test "should get show" do
    get members_order_path(orders(:order1))
    assert_response :success
  end

  test "should get confirm" do
    member = members(:member2)
    login_as(member, :scope => :member)
    post confirm_members_orders_path, params: {order:{ choice: "0",
                                               payment_method: "クレジットカード"}}
    assert_response :success
  end

end
