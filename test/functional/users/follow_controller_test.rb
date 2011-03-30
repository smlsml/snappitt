require 'test_helper'

class Users::FollowControllerTest < ActionController::TestCase

  def setup
    @user = users(:snoop)
    @to = users(:dre)
  end

  test "should get index" do
    get :index, :user_id => @user.id
    assert_response :success
  end

  test "should get show" do
    get :show, :user_id => @user.id
    assert_response :success
  end

  test "should get create" do
    get :create, :user_id => @user.id
    assert_response :success
  end

  test "should get delete" do
    get :delete, :user_id => @user.id, :id => connections(:snoop_dre).id
    assert_response :success
  end

end
