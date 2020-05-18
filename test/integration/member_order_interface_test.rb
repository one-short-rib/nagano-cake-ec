require 'test_helper'

class MemberOrderInterfaceTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers


  def setup
    @order = orders(:order1)
    @member = members(:member1)
    login_as(@member, :scope => :member)
  end

  test "new view" do
    #カートが空の場合
    get new_members_order_path
    assert_template "member/cart_items/index"
    #カートに商品がある場合
    CartItem.create(member_id: @member.id,
                    item: items(:item1),
                    amount: 2)
    get new_members_order_path
    assert_template "member/orders/new"
    assert_select "h2", "注文情報入力"
    assert_select "h3", "支払方法"
    assert_select "h3", "お届け先"
  end

  test "index view" do
    get members_orders_path
    assert_select "h3", "注文履歴一覧"
    assert_match @order.created_at.strftime('%Y/%m/%d').to_s, response.body
    assert_match @order.postal_code, response.body
    assert_match @order.address, response.body
    assert_match @order.items.first.name, response.body
    assert_match @order.billing_amount.to_s(:delimited), response.body
    #assert_match @order.order_status, response.body
    assert_select "form[action=?]", members_order_path(@order)
  end

  test "show view" do
    get members_order_path(@order)
    assert_select "h3", "注文履歴詳細"

    assert_select "h5", "注文情報"
    assert_match @order.created_at.strftime('%Y/%m/%d'), response.body
    assert_match @order.postal_code, response.body
    assert_match @order.address, response.body
    assert_match @order.name, response.body
    #assert_match @order.payment_method, response.body
    #assert_match @order.order_status, response.body

    assert_select "h5", "請求情報"
    #assert_match total_price(@order).to_s, response.body
    assert_match @order.postage.to_s, response.body
    assert_match @order.billing_amount.to_s, response.body

    assert_select "h5", "注文内容"
    order_item = @order.order_items.first
    assert_match order_item.item.name, response.body
    assert_match order_item.order_price.to_s, response.body
    assert_match order_item.amount.to_s, response.body
    #assert_match subtotal(order_item), response.body
  end
end
