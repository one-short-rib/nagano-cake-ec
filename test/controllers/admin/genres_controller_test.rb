require 'test_helper'

class Admin::GenresControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
   get admin_genres_path
   assert_response :success
  end

  test "should get edit" do
   get edit_admin_genre_path(genres(:genre1))
   assert_response :success
  end

end
