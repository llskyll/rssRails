require 'test_helper'

class UserBlogInfosControllerTest < ActionController::TestCase
  setup do
    @user_blog_info = user_blog_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_blog_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_blog_info" do
    assert_difference('UserBlogInfo.count') do
      post :create, user_blog_info: { userId: @user_blog_info.userId, userName: @user_blog_info.userName }
    end

    assert_redirected_to user_blog_info_path(assigns(:user_blog_info))
  end

  test "should show user_blog_info" do
    get :show, id: @user_blog_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_blog_info
    assert_response :success
  end

  test "should update user_blog_info" do
    patch :update, id: @user_blog_info, user_blog_info: { userId: @user_blog_info.userId, userName: @user_blog_info.userName }
    assert_redirected_to user_blog_info_path(assigns(:user_blog_info))
  end

  test "should destroy user_blog_info" do
    assert_difference('UserBlogInfo.count', -1) do
      delete :destroy, id: @user_blog_info
    end

    assert_redirected_to user_blog_infos_path
  end
end
