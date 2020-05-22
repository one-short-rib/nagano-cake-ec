require 'test_helper'

class AdminOrderInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @order = orders(:order1)
  end

  test "admin order show" do
    get admin_order_path(@order)
    assert_template 'admin/orders/show'
    assert_match @order.billing_amount.to_s, response.body
  end
  
end
