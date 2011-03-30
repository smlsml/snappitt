require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, :id => users(:snoop).id
    assert_response :success
  end

end
