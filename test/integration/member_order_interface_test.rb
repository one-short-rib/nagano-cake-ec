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
    CartItem.create(member: @member,
                    item: items(:item1),
                    amount: 2)
    get new_members_order_path
    assert_template "member/orders/new"
    #payment_methodがクレジットカード
    post confirm_members_orders_path, params: {order:{ choice: "0",
                                               payment_method: "クレジットカード"}}
    assert_template 'member/orders/confirm'
    new_order = assigns(:order)
    assert_equal new_order.payment_method, "クレジットカード"
    #payment_methodが銀行振込
    post confirm_members_orders_path, params: {order:{ choice: "0",
                                               payment_method: "銀行振込"}}
    new_order = assigns(:order)
    assert_equal new_order.payment_method, "銀行振込"
    #自分の住所を選択
    post confirm_members_orders_path, params: {order:{ choice: "0",
                                               payment_method: "クレジットカード"}}
    new_order = assigns(:order)
    assert_equal new_order.address, @member.address
    #配送先リストの住所を選択
    post confirm_members_orders_path, params: {order:{ choice: "1",
                                                       ship_id: @member.ships.first.id,
                                               payment_method: "クレジットカード"}}
    new_order = assigns(:order)
    assert_equal new_order.address, @member.ships.first.address
    #配送先の追加を選択
    assert_no_difference 'Ship.count' do
        post confirm_members_orders_path, params: {order:{ choice: "2",
                                               payment_method: "クレジットカード",
                                               ship_postal_code: "7654321",
                                               ship_address: "example_new_address",
                                               ship_name: "example_new_name"}}
    end
    new_order = assigns(:order)
    new_ship = @member.ships.new(postal_code: "7654321",
                                 address: "example_new_address",
                                 name: "example_new_name")
    assert_equal new_order.address, new_ship.address
  end

  test "confirm view" do
    CartItem.create(member: @member,
                    item: items(:item1),
                    amount: 2)
    #配送先記入に失敗
    post confirm_members_orders_path, params: {order:{ choice: "2",
                                                       payment_method: "クレジットカード"}}
    assert_not flash.empty?
    assert_template 'member/orders/new'
    #成功
    post confirm_members_orders_path, params: {order:{ choice: "0",
                                                       payment_method: "クレジットカード"}}
    assert flash.empty?
    assert_template 'member/orders/confirm'
    new_order = assigns(:order)
    assert_match @member.cart_items.first.item.name, response.body
    assert_match new_order.billing_amount.to_s(:delimited), response.body
    assert_match new_order.payment_method, response.body
    assert_match new_order.address, response.body
    assert_select "input[value=?]", "購入を確定する"
  end

  test "create and thanks view" do
    CartItem.create(member: @member,
                    item: items(:item1),
                    amount: 2)
    assert_difference 'CartItem.count', -1 do #member1がcart_item1個の前提
      assert_difference 'Order.count', 1 do
        assert_difference 'OrderItem.count', 1 do
          assert_no_difference 'Ship.count' do
            post members_orders_path, params: {order:{ postal_code: "7654321",
                                                   address: "大阪府高野飯",
                                                   name: "三五郎",
                                                   billing_amount: 100,
                                                   payment_method: "クレジットカード"}}
          end
        end
      end
    end
    assert_redirected_to thanks_members_orders_path
    new_order = assigns(:order)
    assert_equal new_order.order_items.count, 1
    follow_redirect!
    assert_select "h2", "ご購入ありがとうございました！"

    #新しい配送先を作成した場合
    CartItem.create(member: @member,
                    item: items(:item1),
                    amount: 2)
    assert_difference 'CartItem.count', -1 do
      assert_difference 'Order.count', 1 do
        assert_difference 'OrderItem.count', 1 do
          assert_difference 'Ship.count', 1 do
            post members_orders_path, params: {order:{ postal_code: "7654321",
                                                   address: "大阪府高野飯",
                                                   name: "三五郎",
                                                   billing_amount: 100,
                                                   payment_method: "クレジットカード",
                                                   new_ship: true}}
          end
        end
      end
    end
  end

  test "index view" do
    get members_orders_path
    assert_template 'member/orders/index'
    assert_match @order.created_at.strftime('%Y/%m/%d').to_s, response.body
    assert_match @order.postal_code, response.body
    assert_match @order.address, response.body
    assert_match @order.items.first.name, response.body
    assert_match @order.billing_amount.to_s(:delimited), response.body
    assert_match @order.order_status, response.body
    assert_select "a[href=?]", members_order_path(@order)
    #他人の注文履歴
    assert_no_match orders(:order3).billing_amount.to_s(:delimited), response.body
  end

  test "show view" do
    get members_order_path(@order)
    assert_template 'member/orders/show'
    assert_match @order.created_at.strftime('%Y/%m/%d'), response.body
    assert_match @order.postal_code, response.body
    assert_match @order.address, response.body
    assert_match @order.name, response.body
    assert_match @order.payment_method, response.body
    assert_match @order.order_status, response.body

    assert_match @order.postage.to_s, response.body
    assert_match @order.billing_amount.to_s(:delimited), response.body

    order_item = @order.order_items.first
    assert_match order_item.item.name, response.body
    assert_match order_item.order_price.to_s, response.body
    assert_match order_item.amount.to_s, response.body
    assert_match (order_item.order_price*order_item.amount).to_s(:delimited), response.body
  end
end
