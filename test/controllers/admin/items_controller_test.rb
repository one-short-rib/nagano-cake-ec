require 'test_helper'

class Admin::ItemsControllerTest < ActionDispatch::IntegrationTest
    include Warden::Test::Helpers

      def setup
        @admin = admins(:admin1)
        login_as(@admin, :scope => :admin)
      end

      test "should get new" do
        get new_admin_item_path
        assert_response :success
      end

      test "should get show" do
        get admin_item_path(items(:item1))
        assert_response :success
      end

      test "should get index" do
       get admin_items_path
       assert_response :success
      end

      test "should get edit" do
       get edit_admin_item_path(items(:item1))
       assert_response :success
      end

end
