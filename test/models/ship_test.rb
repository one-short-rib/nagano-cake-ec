require 'test_helper'

class ShipTest < ActiveSupport::TestCase

  def setup
    @ship = Ship.create(member: members(:member1),
                        postal_code: "1234567",
                        address: "example address",
                        name: "example name")
  end

  test "should be valid" do
    assert @ship.valid?
  end

  test "postal_code should present" do
    @ship.postal_code = ""
    assert_not @ship.valid?
  end

  test "address should present" do
    @ship.address = ""
    assert_not @ship.valid?
  end

  test "name should present" do
    @ship.name = ""
    assert_not @ship.valid?
  end

  test "postal_code should be less than 8 letters" do
    @ship.postal_code = "a"*8
    assert_not @ship.valid?
  end

  test "address should not be too long" do
    @ship.address = "a"*256
    assert_not @ship.valid?
  end

  test "name should not be too long" do
    @ship.name = "a"*21
    assert_not @ship.valid?
  end

end
