require 'test_helper'

class HeaderTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @admin = admins(:admin1)
    @member = members(:member1)
  end

  test "visitor can see visitor header" do
    get root_path
    assert_select "a[href=?]", items_path, count: 2
    assert_select "a[href=?]", new_member_registration_path
    assert_select "a[href=?]", new_member_session_path
  end

  test "admin can see admin header" do
    login_as(@admin, :scope => :admin)
    get admin_path
    assert_select "a[href=?]", admin_items_path
    assert_select "a[href=?]", admin_members_path
    assert_select "a[href=?]", admin_orders_path
    assert_select "a[href=?]", admin_genres_path
  end

  test "non-admin cannot see admin header" do
    login_as(@member, :scope => nil)
    get root_path
    assert_select "a[href=?]", admin_items_path, count: 0
    assert_select "a[href=?]", admin_members_path, count: 0
    assert_select "a[href=?]", admin_orders_path, count: 0
    assert_select "a[href=?]", admin_genres_path, count: 0
    login_as(@member, :scope => :member)
    assert_select "a[href=?]", admin_items_path, count: 0
    assert_select "a[href=?]", admin_members_path, count: 0
    assert_select "a[href=?]", admin_orders_path, count: 0
    assert_select "a[href=?]", admin_genres_path, count: 0
  end

  test "member can see member header" do
    login_as(@member, :scope => :member)
    get root_path
    assert_select "a[href=?]", members_path
    assert_select "a[href=?]", items_path, count: 2
    assert_select "a[href=?]", members_cart_items_path
    assert_select "a[href=?]", destroy_member_session_path
  end

  test "non-member cannot see member header" do
    get root_path
    assert_select "a[href=?]", members_path, count: 0
    assert_select "a[href=?]", items_path, count: 2
    assert_select "a[href=?]", members_cart_items_path, count: 0
    assert_select "a[href=?]", destroy_member_session_path, count: 0
    login_as(@admin, :scope => :admin)
    get admin_path
    assert_select "a[href=?]", members_path, count: 0
    assert_select "a[href=?]", items_path, count: 0
    assert_select "a[href=?]", members_cart_items_path, count: 0
    assert_select "a[href=?]", destroy_member_session_path, count: 0
  end

end
