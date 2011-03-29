require 'test_helper'

class MomentsControllerTest < ActionController::TestCase

  test "should get show" do
    get :show, :experience_id => 1, :id => 1
    assert_response :success
  end

end
