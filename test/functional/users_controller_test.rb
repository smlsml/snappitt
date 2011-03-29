require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get index" do
    get :show
    assert_response :success
  end

  test "should get show" do
    get :show, :controller => 'people', :id => users(:snoop).id
    assert_response :success
  end

end
