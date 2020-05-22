require 'test_helper'

class Admin::MembersControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
   get admin_members_path
   assert_response :success
  end

  test "should get show" do
   get admin_member_path(members(:member1))
   assert_response :success
  end

  test "should get edit" do
   get edit_admin_member_path(members(:member1))
   assert_response :success
  end

end
