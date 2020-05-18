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
    #payment_methodがクレジットカード
    post confirm_members_orders_path, params: {order:{ name: "0",
                                               payment_method: "クレジットカード"}}
    assert_template 'member/orders/confirm'
    new_order = assigns(:order)
    assert_equal new_order.payment_method, "クレジットカード"
    #payment_methodが銀行振込
    post confirm_members_orders_path, params: {order:{ name: "0",
                                               payment_method: "銀行振込"}}
    new_order = assigns(:order)
    assert_equal new_order.payment_method, "銀行振込"
    #自分の住所を選択
    post confirm_members_orders_path, params: {order:{ name: "0",
                                               payment_method: "クレジットカード"}}
    new_order = assigns(:order)
    assert_equal new_order.address, @member.address
    #配送先リストの住所を選択
    post confirm_members_orders_path, params: {order:{ name: "1",
                                                       address: @member.ships.first.id,
                                               payment_method: "クレジットカード"}}
    new_order = assigns(:order)
    assert_equal new_order.address, @member.ships.first.address
    #配送先の追加を選択
    post confirm_members_orders_path, params: {order:{ name: "2",
                                               payment_method: "クレジットカード",
                                               ship_postal_code: "7654321",
                                               ship_address: "example_new_address",
                                               ship_name: "example_new_name"}}
    new_order = assigns(:order)
    new_ship = @member.ships.new(postal_code: "7654321",
                                 address: "example_new_address",
                                 name: "example_new_name")
    assert_equal new_order.address, new_ship.address
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
