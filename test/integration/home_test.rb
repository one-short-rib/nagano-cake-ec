require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest

    test "top view" do
      get root_path
      assert_select "p", "ようこそ、NaganoCakeへ！
          このサイトは、ケーキ販売のECサイトになります。
          会員でない方も商品の閲覧はできますが、
          購入には会員登録が必要になります。"
      assert_select "h2", "オススメ商品"
      assert_select "div.genres-box"
      assert_select "div.item-box"
      assert_select "a[href=?]", items_path
    end

    test "about view" do
      get about_path
      assert_select "h2", "このECサイトについて"
    end

end
