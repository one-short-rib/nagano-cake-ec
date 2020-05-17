require 'test_helper'

class MemberOrderInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @order = orders(:order1)
  end

  test "index view" do
    get members_orders_path
    assert_select "h3", "注文履歴一覧"
    assert_match @order.created_at.strftime('%Y/%m/%d').to_s, response.body
    assert_match @order.postal_code, response.body
    assert_match @order.address, response.body
    #assert_match @order.items.first.name, response.body
    assert_match @order.billing_amount.to_s(:delimited), response.body
    #assert_match @order.order_status, response.body
  end
end
