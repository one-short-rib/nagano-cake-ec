require 'test_helper'

class AdminOrderInterfaceTest < ActionDispatch::IntegrationTest
    include Warden::Test::Helpers

  def setup
    @admin = admins(:admin1)
    login_as(@admin, :scope => :admin)
    @order = orders(:order1)
  end

  test "admin order show" do
    get admin_order_path(@order)
    assert_template 'admin/orders/show'
    assert_match @order.billing_amount.to_s(:delimited), response.body
  end

end
