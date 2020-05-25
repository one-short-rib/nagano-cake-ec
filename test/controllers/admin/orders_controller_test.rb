require 'test_helper'

class Admin::OrdersControllerTest < ActionDispatch::IntegrationTest
    include Warden::Test::Helpers

  def setup
    @admin = admins(:admin1)
    login_as(@admin, :scope => :admin)
  end

  test "should get index" do
   get admin_orders_path
   assert_response :success
  end

  test "should get show" do
   get admin_order_path(orders(:order1))
   assert_response :success
  end

end
