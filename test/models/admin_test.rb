require 'test_helper'

class AdminTest < ActiveSupport::TestCase

    def setup
      @admin = Admin.create(email: "admin@example.com",
                            password: "password")
    end

    test "should be valid" do
      assert @admin.valid?
    end

    test "email should present" do
      @admin.email = ""
      assert_not @admin.valid?
    end

    test "password should present" do
      @admin.password = ""
      assert_not @admin.valid?
    end

    test "email should not be too long" do
      @admin.email = "a"*256
      assert_not @admin.valid?
    end

end
