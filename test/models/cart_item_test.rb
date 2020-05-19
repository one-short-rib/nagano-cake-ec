require 'test_helper'

class CartItemTest < ActiveSupport::TestCase

  def setup
    @cart_item = CartItem.create(member: members(:member1),
                                 item: items(:item1),
                                 amount: 0)
  end

  test "should be valid" do
    assert @cart_item.valid?
  end

  test "amount should present" do
    @cart_item.amount = nil
    assert_not @cart_item.valid?
  end
end
