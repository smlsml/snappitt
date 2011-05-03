require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  def setup
    @user = users(:dre)
    sign_in(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, :id => events(:artopia).id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

end
