require 'test_helper'

class Member::MembersControllerTest < ActionDispatch::IntegrationTest
    include Warden::Test::Helpers

  def setup
    @member = members(:member1)
  end

  test "should get show" do
    login_as(@member, :scope => :member)
    get members_path(@member)
    assert_response :success
  end

  test "should get edit" do
    login_as(@member, :scope => :member)
    get edit_members_path(@member)
    assert_response :success
  end

  test "should get exit" do
    get exit_members_path
    assert_response :success
  end

end
