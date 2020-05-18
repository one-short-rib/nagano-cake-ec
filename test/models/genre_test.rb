require 'test_helper'

class GenreTest < ActiveSupport::TestCase

  def setup
    @genre = Genre.new(name: "example")
  end

  test "should be valid" do
    assert @genre.valid?
  end

  test "name should present" do
    @genre.name = ""
    assert_not @genre.valid?
  end

  test "is_valid should be true in default" do
    assert @genre.is_valid
  end

end
