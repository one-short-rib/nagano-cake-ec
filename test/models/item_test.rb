require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  def setup
    picture = fixture_file_upload('test/fixtures/sample1.jpg', 'image/png')
    @item = Item.new(genre: genres(:genre1),
                     name: "example",
                     explanation: "example explanation",
                     price: 0,
                     item_image: picture)
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "name should present" do
    @item.name = ""
    assert_not @item.valid?
  end

  test "explanation should present" do
    @item.explanation = ""
    assert_not @item.valid?
  end

  test "price should present" do
    @item.price = nil
    assert_not @item.valid?
  end

  test "is_saled should be true for default" do
    assert @item.is_saled
  end

end
