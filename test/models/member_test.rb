require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  def setup
    @member = Member.create(last_name: "試験",
                            first_name: "大輔",
                            last_name_kana: "シケン",
                            first_name_kana: "ダイスケ",
                            phone_number: "1234567890",
                            postal_code: "1234567",
                            address: "example_address",
                            email: "member@example.com",
                            password: "password")
  end

  test "should be valid" do
    assert @member.valid?
  end

  test "last_name should present" do
    @member.last_name = ""
    assert_not @member.valid?
  end

  test "first_name should present" do
    @member.first_name = ""
    assert_not @member.valid?
  end

  test "last_name_kana should present" do
    @member.last_name_kana = ""
    assert_not @member.valid?
  end

  test "first_name_kana should present" do
    @member.first_name_kana = ""
    assert_not @member.valid?
  end

  test "phone_number should present" do
    @member.phone_number = ""
    assert_not @member.valid?
  end

  test "postal_code should present" do
    @member.postal_code = ""
    assert_not @member.valid?
  end

  test "address should present" do
    @member.address = ""
    assert_not @member.valid?
  end

  test "email should present" do
    @member.email = ""
    assert_not @member.valid?
  end

  test "last_name should be less than 11 letters" do
    @member.last_name = "a"*11
    assert_not @member.valid?
  end

  test "first_name should be less than 11 letters" do
    @member.first_name = "a"*11
    assert_not @member.valid?
  end

  test "last_name_kana should be less than 11 letters" do
    @member.last_name_kana = "a"*11
    assert_not @member.valid?
  end

  test "first_name_kana should be less than 11 letters" do
    @member.first_name_kana = "a"*11
    assert_not @member.valid?
  end

  test "phone_number should be 10 ~ 12 letters" do
    @member.phone_number = "a"*9
    assert_not @member.valid?
    @member.phone_number = "a"*13
    assert_not @member.valid?
  end

  test "postal_code should be less than 8 letters" do
    @member.postal_code = "a"*8
    assert_not @member.valid?
  end

  test "address should not be too long" do
    @member.address = "a"*256
    assert_not @member.valid?
  end

  test "email should not be too long" do
    @member.email = "a"*256
    assert_not @member.valid?
  end

end
