require 'test_helper'

class Users::FollowControllerTest < ActionController::TestCase

  def setup
    @user = users(:snoop)
    sign_in(@user)
    @to = users(:dre)
  end

  test "get index" do
    get :index, :user_id => @user.id
    assert_response :success
  end

  test "should show" do
    get :show, :id => @to, :user_id => @user
    assert_response :success
  end

  test "should create" do
    get :create, :user_id => @user
    assert_redirected_to user_follow_index_path(@user)
  end

  test "should destroy" do
    get :destroy, :user_id => @user, :id => connections(:snoop_dre)
    assert_redirected_to user_follow_index_path(@user)
  end

end
