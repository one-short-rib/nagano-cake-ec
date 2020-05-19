require 'test_helper'

class Member::CartItemsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  test "should get index" do
    member = members(:member1)
    login_as(member, :scope => :member)
    get members_cart_items_path
    assert_response :success
  end

end
