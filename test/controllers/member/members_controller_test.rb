require 'test_helper'

class Member::MembersControllerTest < ActionDispatch::IntegrationTest
    include Warden::Test::Helpers

  def setup
    @member = members(:member1)
      login_as(@member, :scope => :member)
  end

  test "should get show" do
    get members_path(@member)
    assert_response :success
  end

  test "should get edit" do
    get edit_members_path(@member)
    assert_response :success
  end

  test "should get exit" do
    get exit_members_path
    assert_response :success
  end

end
