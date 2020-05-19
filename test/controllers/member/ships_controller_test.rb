require 'test_helper'

class Member::ShipsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @member = members(:member2)
    login_as(@member, :scope => :member)
  end

  test "should get index" do
    get members_ships_path
    assert_response :success
  end

  test "should get edit" do
    get edit_members_ship_path(ships(:ship1))
    assert_response :success
  end

end
