require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase

  def setup
    @order_item = OrderItem.create(item: items(:item1),
                                    order: orders(:order1),
                                    amount: 2,
                                    order_price: 130)
  end

  test "should be valid" do
    assert @order_item.valid?
  end

  test "amount should present" do
    @order_item.amount = nil
    assert_not @order_item.valid?
  end

  test "making_status should present" do
    @order_item.making_status = nil
    assert_not @order_item.valid?
  end

  test "order_price should present" do
    @order_item.order_price = nil
    assert_not @order_item.valid?
  end

  test "making_status should be 0 in default" do
  #  assert_equal @order_item.making_status, :着手不可
  end

end
