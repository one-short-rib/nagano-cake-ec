require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  def setup
    @order = Order.new(member: members(:member1),
                       postal_code: "2345678",
                       address: "example_address",
                       name: "example_name",
                       billing_amount: 100)
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "postal_code should present" do
    @order.postal_code = ""
    assert_not @order.valid?
  end

  test "address should present" do
    @order.address = ""
    assert_not @order.valid?
  end

  test "name should present" do
    @order.name = ""
    assert_not @order.valid?
  end

  test "postage should present" do
    @order.postage = nil
    assert_not @order.valid?
  end

  test "billing_amount should present" do
    @order.billing_amount = nil
    assert_not @order.valid?
  end

  test "postal_code should be 7 letters" do
    @order.postal_code = "0"*8
    assert_not @order.valid?
    @order.postal_code = "0"*6
    assert_not @order.valid?
  end

  test "address should not be too long" do
    @order.address = "a"*256
    assert_not @order.valid?
  end

  test "name should not be too long" do
    @order.name = "a"*256
    assert_not @order.valid?
  end

  test "defaults should be valid" do
    assert_equal @order.order_status, "入金待ち"
    assert_equal @order.postage, 800
    assert_equal @order.payment_method, "クレジットカード"
  end


end
