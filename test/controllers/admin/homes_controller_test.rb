require 'test_helper'

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
    include Warden::Test::Helpers

  def setup
    @admin = admins(:admin1)
    login_as(@admin, :scope => :admin)
  end

  test "should get top" do
    get admin_path
    assert_response :success
  end

 end
