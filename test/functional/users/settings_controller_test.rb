require 'test_helper'

class Users::SettingsControllerTest < ActionController::TestCase

  test "the truth" do
    sign_in(users(:snoop))
    get :show, :user_id => users(:snoop).id
    assert_response :success
  end

end
