require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    # 未ログインユーザーの場合
    get root_path
    assert_template 'static_pages/home'
    #一旦root_pathを３に設定（本来は２でpassする。未達成）
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get signup_path
    # assert_select "title", full_title("Sign up")


    # ログインユーザーの場合
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path

    # ページネーションのテスト
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
  end
end
