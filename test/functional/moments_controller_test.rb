require 'test_helper'

class MomentsControllerTest < ActionController::TestCase

  test "should get show" do
    get :show, :experience_id => experiences(:group).id, :id => moments(:eat)
    assert_response :success
  end

end
